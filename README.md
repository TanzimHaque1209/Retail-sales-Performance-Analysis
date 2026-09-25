# Retail Sales Performance Analysis

## Project Overview

This project analyzes retail sales data using MySQL to understand sales performance, customer behavior, product performance, and sales trends.

The project follows a structured workflow beginning with data validation and progressing through core business analysis, advanced SQL techniques, time-series analysis, customer and product analysis, and query optimization.

## Dataset

The project uses three related datasets:

- **sales.csv** — transaction-level sales data
- **customers.csv** — customer information and customer segments
- **products.csv** — product information, categories, and unit prices

The working dataset contains **3,000 sales transactions**, **200 customers**, and **40 products**, covering **2024–2025**.

## Database Structure

The analysis is based on three related tables:

- **sales** — order ID, customer ID, product ID, region, quantity, sales amount, order date, and discount
- **customers** — customer ID, customer name, and customer segment
- **product** — product ID, product name, category, and unit price

The `sales` table connects to the customer and product tables through customer and product IDs.

## Project Objectives

The analysis explores questions such as:

- How much revenue and sales volume did the business generate?
- Which products and categories generated the most revenue?
- How did sales change over time?
- Which customers generated the most revenue?
- How do customer segments compare?
- Which products contribute the most revenue within their categories?
- Which are the top-performing products within each category?
- How much does each customer contribute to total company revenue?
- How does monthly revenue change compared with the previous month?

## Data Quality Checks

Before performing the analysis, the dataset was validated for:

- Missing values
- Duplicate order IDs
- Invalid quantities, sales amounts, and discount values
- Sales amount calculation consistency
- Customer referential integrity
- Product referential integrity

Sales amounts were checked against:

`quantity × unit price × (1 - discount)`

## SQL Analysis

### Core Business Analysis

- Overall sales KPIs
- Sales by region
- Sales by product
- Sales by category
- Customer revenue analysis
- Customer segment analysis
- Monthly and yearly sales trends

### Advanced SQL Analysis

- Transactions above average sales value
- Customers generating above-average revenue
- Sales value classification using `CASE`
- Common Table Expressions (CTEs)

### Window Function Analysis

- Product revenue ranking
- Product ranking within categories
- Running monthly sales totals
- Previous-month sales comparison using `LAG()`
- Month-over-month sales growth

### Portfolio Business Analysis

- Top three products within each category
- Product contribution to category revenue
- Customer revenue ranking
- Customer contribution to total company revenue

## Query Optimization

`EXPLAIN` was used to inspect MySQL execution plans.

A date-range query on `order_date` was examined before and after creating an index:

```sql
CREATE INDEX idx_sales_order_date
ON sales(order_date);
```

`SHOW INDEX` was also used to inspect available indexes, and an additional customer-sales join query was examined with `EXPLAIN`.

The purpose of this section is to demonstrate execution-plan analysis and practical indexing rather than assume that an index always improves performance.

## Repository Structure

```text
retail-sales-performance-analysis/
│
├── README.md
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   └── sales.csv
│
└── sql/
    ├── 01_schema.sql
    ├── 02_data_quality_checks.sql
    ├── 03_core_business_analysis.sql
    ├── 04_advanced_sql_analysis.sql
    ├── 05_window_functions.sql
    ├── 06_portfolio_business_analysis.sql
    └── 07_query_optimization.sql
```

## SQL Skills Demonstrated

MySQL, relational database design, JOINs, aggregate functions, GROUP BY, HAVING, subqueries, CASE expressions, CTEs, window functions, `ROW_NUMBER()`, `DENSE_RANK()`, `LAG()`, running totals, time-series analysis, indexing, and `EXPLAIN`.

## How to Use This Project

1. Create the database and tables using `sql/01_schema.sql`.
2. Import the CSV files from the `data` folder into their corresponding tables.
3. Run `sql/02_data_quality_checks.sql` to validate the data.
4. Run the remaining SQL files in numerical order to reproduce the analysis.
5. Review `sql/07_query_optimization.sql` separately when examining execution plans and indexing.

## Tools Used

- MySQL
- MySQL Workbench
- GitHub

## Author

**Tanzim Haque**
