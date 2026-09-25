USE company_db;

-- Above-average transactions
SELECT order_id, customer_id, product_id, sales_amount
FROM sales
WHERE sales_amount > (SELECT AVG(sales_amount) FROM sales);

-- Customers above average customer revenue
SELECT customer_id, SUM(sales_amount) AS total_sales
FROM sales
GROUP BY customer_id
HAVING SUM(sales_amount) > (
 SELECT AVG(customer_total)
 FROM (
   SELECT customer_id, SUM(sales_amount) AS customer_total
   FROM sales GROUP BY customer_id
 ) AS customer_totals
)
ORDER BY total_sales DESC;

-- Transaction value classification
SELECT order_id, sales_amount,
 CASE
   WHEN sales_amount < 500 THEN 'Low Value'
   WHEN sales_amount < 1500 THEN 'Medium Value'
   ELSE 'High Value'
 END AS sales_category
FROM sales;

-- Reusable CTE analysis
WITH customer_revenue AS (
 SELECT customer_id, SUM(sales_amount) AS total_sales
 FROM sales GROUP BY customer_id
)
SELECT *
FROM customer_revenue
WHERE total_sales > (SELECT AVG(total_sales) FROM customer_revenue)
ORDER BY total_sales DESC;
