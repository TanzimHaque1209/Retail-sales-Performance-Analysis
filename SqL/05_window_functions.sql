USE company_db;

-- Product revenue ranking
WITH product_revenue AS (
 SELECT product_id, SUM(sales_amount) AS total_sales
 FROM sales GROUP BY product_id
)
SELECT product_id, total_sales,
       DENSE_RANK() OVER (ORDER BY total_sales DESC) AS product_rank
FROM product_revenue;

-- Ranking within category
WITH product_info AS (
 SELECT p.product_id, p.product_name, p.category,
        SUM(s.sales_amount) AS total_sales
 FROM product p JOIN sales s ON p.product_id = s.product_id
 GROUP BY p.product_id, p.product_name, p.category
)
SELECT category, product_id, product_name, total_sales,
       DENSE_RANK() OVER (
         PARTITION BY category ORDER BY total_sales DESC
       ) AS product_rank
FROM product_info;

-- Running monthly revenue
WITH monthly_sales AS (
 SELECT YEAR(order_date) AS sale_year,
        MONTH(order_date) AS sale_month,
        SUM(sales_amount) AS total_sales
 FROM sales
 GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT sale_year, sale_month, total_sales,
       SUM(total_sales) OVER (
         ORDER BY sale_year, sale_month
       ) AS running_total
FROM monthly_sales;

-- Month-over-month growth
WITH month_year_sales AS (
 SELECT YEAR(order_date) AS sale_year,
        MONTH(order_date) AS sale_month,
        SUM(sales_amount) AS total_sales
 FROM sales
 GROUP BY YEAR(order_date), MONTH(order_date)
),
sales_comparison AS (
 SELECT sale_year, sale_month, total_sales,
        LAG(total_sales) OVER (
          ORDER BY sale_year, sale_month
        ) AS previous_sales
 FROM month_year_sales
)
SELECT sale_year, sale_month, total_sales, previous_sales,
       ROUND(((total_sales - previous_sales) /
              NULLIF(previous_sales, 0)) * 100, 2) AS mom_growth_percentage
FROM sales_comparison;
