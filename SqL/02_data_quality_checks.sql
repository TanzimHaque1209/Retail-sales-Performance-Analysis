USE company_db;

-- Null checks
SELECT
 SUM(order_id IS NULL) AS null_order_id,
 SUM(customer_id IS NULL) AS null_customer_id,
 SUM(region IS NULL) AS null_region,
 SUM(product_id IS NULL) AS null_product_id,
 SUM(quantity IS NULL) AS null_quantity,
 SUM(sales_amount IS NULL) AS null_sales_amount,
 SUM(order_date IS NULL) AS null_order_date,
 SUM(discount IS NULL) AS null_discount
FROM sales;

-- Duplicate order IDs
SELECT order_id, COUNT(*) AS duplicate_count
FROM sales
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Invalid values
SELECT *
FROM sales
WHERE quantity <= 0 OR sales_amount < 0 OR discount < 0 OR discount > 1;

-- Sales amount validation
SELECT s.order_id, s.quantity, p.unit_price, s.discount, s.sales_amount,
       ROUND(s.quantity * p.unit_price * (1 - s.discount), 2) AS calculated_sales
FROM sales s
JOIN product p ON s.product_id = p.product_id
WHERE s.sales_amount <> ROUND(s.quantity * p.unit_price * (1 - s.discount), 2);

-- Referential integrity
SELECT s.order_id, s.customer_id
FROM sales s LEFT JOIN customers c ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT s.order_id, s.product_id
FROM sales s LEFT JOIN product p ON s.product_id = p.product_id
WHERE p.product_id IS NULL;
