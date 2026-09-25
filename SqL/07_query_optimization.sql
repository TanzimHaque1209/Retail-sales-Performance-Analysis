USE company_db;

-- Baseline execution plan: run before creating the date index.
EXPLAIN
SELECT *
FROM sales
WHERE order_date BETWEEN '2025-01-01' AND '2025-03-31';

-- Create once; skip if this index already exists.
CREATE INDEX idx_sales_order_date ON sales(order_date);

-- Compare the execution plan after indexing.
EXPLAIN
SELECT *
FROM sales
WHERE order_date BETWEEN '2025-01-01' AND '2025-03-31';

SHOW INDEX FROM sales;

-- Customer-specific join plan
EXPLAIN
SELECT c.customer_id, c.customer_name, s.order_id, s.sales_amount
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE c.customer_id = 250;
