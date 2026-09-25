USE company_db;

-- Overall KPIs
SELECT SUM(sales_amount) AS total_sales,
       AVG(sales_amount) AS average_sales,
       SUM(quantity) AS total_quantity,
       COUNT(order_id) AS total_orders
FROM sales;

-- Revenue by region
SELECT region, SUM(sales_amount) AS total_sales
FROM sales GROUP BY region ORDER BY total_sales DESC;

-- Revenue by category
SELECT p.category, SUM(s.sales_amount) AS total_sales
FROM sales s JOIN product p ON s.product_id = p.product_id
GROUP BY p.category ORDER BY total_sales DESC;

-- Product performance
SELECT s.product_id, p.product_name, p.category,
       SUM(s.sales_amount) AS total_sales
FROM sales s JOIN product p ON s.product_id = p.product_id
GROUP BY s.product_id, p.product_name, p.category
ORDER BY total_sales DESC;

-- Customer performance
SELECT c.customer_id, c.customer_name, c.customer_segment,
       SUM(s.sales_amount) AS total_sales
FROM customers c JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name, c.customer_segment
ORDER BY total_sales DESC;

-- Customer segment performance
SELECT c.customer_segment, SUM(s.sales_amount) AS total_sales
FROM customers c JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_segment ORDER BY total_sales DESC;

-- Monthly trend
SELECT YEAR(order_date) AS sale_year, MONTH(order_date) AS sale_month,
       SUM(sales_amount) AS total_sales
FROM sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY sale_year, sale_month;

-- Yearly trend
SELECT YEAR(order_date) AS sale_year, SUM(sales_amount) AS total_sales
FROM sales GROUP BY YEAR(order_date) ORDER BY sale_year;
