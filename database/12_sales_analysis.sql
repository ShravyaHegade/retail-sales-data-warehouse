
-- =========================================================
-- RETAIL SALES DATA WAREHOUSE
-- File: 12_sales_analysis.sql
-- Purpose: Answer business questions using warehouse data.
-- =========================================================


-- 1. Overall Sales Summary
-- How many transactions and units were recorded?

SELECT
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_units_sold,
    ROUND(AVG(quantity), 2) AS avg_units_per_transaction,
    ROUND(AVG(discount), 4) AS avg_discount
FROM warehouse.fact_sales;


-- 2. Sales Volume by Product
-- Which products have the highest quantity sold?

SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(f.quantity) AS total_units_sold,
    COUNT(*) AS transaction_count
FROM warehouse.fact_sales f
JOIN warehouse.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_units_sold DESC
LIMIT 10;


-- 3. Sales Volume by Product Category
-- Which categories have the highest quantity sold?

SELECT
    p.category,
    SUM(f.quantity) AS total_units_sold,
    COUNT(*) AS transaction_count,
    COUNT(DISTINCT f.transaction_id) AS distinct_transactions
FROM warehouse.fact_sales f
JOIN warehouse.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_units_sold DESC;


-- 4. Sales Activity by Store
-- Which stores handle the most transactions and units?

SELECT
    s.store_id,
    s.store_name,
    s.city,
    s.region,
    COUNT(*) AS transaction_count,
    SUM(f.quantity) AS total_units_sold
FROM warehouse.fact_sales f
JOIN warehouse.dim_store s
    ON f.store_key = s.store_key
GROUP BY
    s.store_id,
    s.store_name,
    s.city,
    s.region
ORDER BY transaction_count DESC;


-- 5. Payment Method Analysis
-- Which payment methods are used most often?

SELECT
    pm.payment_method,
    COUNT(*) AS transaction_count,
    SUM(f.quantity) AS total_units_sold,
    ROUND(AVG(f.discount), 4) AS avg_discount
FROM warehouse.fact_sales f
JOIN warehouse.dim_payment_method pm
    ON f.payment_method_key = pm.payment_method_key
GROUP BY pm.payment_method
ORDER BY transaction_count DESC;


-- 6. Monthly Sales Trend
-- How does transaction activity change by month?

SELECT
    d.year,
    d.month,
    COUNT(*) AS transaction_count,
    SUM(f.quantity) AS total_units_sold
FROM warehouse.fact_sales f
JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month
ORDER BY
    d.year,
    d.month;


-- 7. Sales Activity by Region
-- Which regions have the most transactions and units?

SELECT
    s.region,
    COUNT(*) AS transaction_count,
    SUM(f.quantity) AS total_units_sold
FROM warehouse.fact_sales f
JOIN warehouse.dim_store s
    ON f.store_key = s.store_key
GROUP BY s.region
ORDER BY total_units_sold DESC;


-- 8. Daily Sales Activity
-- Which dates had the most transaction activity?

SELECT
    d.date,
    COUNT(*) AS transaction_count,
    SUM(f.quantity) AS total_units_sold
FROM warehouse.fact_sales f
JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.date
ORDER BY transaction_count DESC, d.date;


-- 9. Discount Analysis
-- Compare transaction counts and quantities by discount level.

SELECT
    f.discount,
    COUNT(*) AS transaction_count,
    SUM(f.quantity) AS total_units_sold,
    ROUND(AVG(f.quantity), 2) AS avg_units_per_transaction
FROM warehouse.fact_sales f
GROUP BY f.discount
ORDER BY f.discount;


-- 10. Product Category and Region Analysis
-- Compare sales volume across categories and regions.

SELECT
    s.region,
    p.category,
    COUNT(*) AS transaction_count,
    SUM(f.quantity) AS total_units_sold
FROM warehouse.fact_sales f
JOIN warehouse.dim_store s
    ON f.store_key = s.store_key
JOIN warehouse.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    s.region,
    p.category
ORDER BY
    s.region,
    total_units_sold DESC;
