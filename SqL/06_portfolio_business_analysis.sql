USE company_db;

-- Top 3 products per category
WITH product_info AS (
 SELECT p.product_id, p.product_name, p.category,
        SUM(s.sales_amount) AS total_sales
 FROM product p JOIN sales s ON p.product_id = s.product_id
 GROUP BY p.product_id, p.product_name, p.category
),
product_rank AS (
 SELECT product_id, product_name, category, total_sales,
        DENSE_RANK() OVER (
          PARTITION BY category ORDER BY total_sales DESC
        ) AS ranking
 FROM product_info
)
SELECT product_id, product_name, category, total_sales, ranking
FROM product_rank
WHERE ranking <= 3
ORDER BY category, ranking;

-- Product contribution to category revenue
WITH product_info AS (
 SELECT p.product_id, p.product_name, p.category,
        SUM(s.sales_amount) AS total_sales
 FROM product p JOIN sales s ON p.product_id = s.product_id
 GROUP BY p.product_id, p.product_name, p.category
),
category_info AS (
 SELECT product_id, product_name, category, total_sales,
        SUM(total_sales) OVER (PARTITION BY category) AS category_sales
 FROM product_info
)
SELECT product_id, product_name, category, total_sales, category_sales,
       ROUND((total_sales / category_sales) * 100, 2) AS contribution_percentage
FROM category_info
ORDER BY category, contribution_percentage DESC;

-- Customer ranking
WITH customer_revenue AS (
 SELECT c.customer_id, c.customer_name, c.customer_segment,
        SUM(s.sales_amount) AS total_revenue
 FROM customers c JOIN sales s ON c.customer_id = s.customer_id
 GROUP BY c.customer_id, c.customer_name, c.customer_segment
)
SELECT customer_id, customer_name, customer_segment, total_revenue,
       DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS customer_rank
FROM customer_revenue
ORDER BY customer_rank;

-- Customer contribution to company revenue
WITH customer_revenue AS (
 SELECT c.customer_id, c.customer_name, c.customer_segment,
        SUM(s.sales_amount) AS total_revenue
 FROM customers c JOIN sales s ON c.customer_id = s.customer_id
 GROUP BY c.customer_id, c.customer_name, c.customer_segment
),
company_revenue_calc AS (
 SELECT customer_id, customer_name, customer_segment, total_revenue,
        SUM(total_revenue) OVER () AS company_revenue
 FROM customer_revenue
)
SELECT customer_id, customer_name, customer_segment, total_revenue,
       company_revenue,
       ROUND((total_revenue / company_revenue) * 100, 2)
         AS customer_revenue_percentage
FROM company_revenue_calc
ORDER BY customer_revenue_percentage DESC;
