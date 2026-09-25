CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_segment VARCHAR(50)
);

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_id INT,
    region VARCHAR(50),
    product_id INT,
    quantity INT,
    sales_amount DECIMAL(10,2),
    order_date DATE,
    discount DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
