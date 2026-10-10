-- Load dimension tables from STAGING into the WAREHOUSE.
-- Surrogate keys are generated using ROW_NUMBER() for this initial load.
-- This script assumes the dimension tables are empty.


-- =========================================================
-- 1. Load Customer Dimension
-- =========================================================

INSERT INTO warehouse.dim_customer (
    customer_key,
    customer_id,
    first_name,
    last_name,
    gender,
    birth_date,
    city,
    join_date
)
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id)::INTEGER,
    customer_id,
    first_name,
    last_name,
    gender,
    birth_date,
    city,
    join_date
FROM staging.stg_customers;


-- =========================================================
-- 2. Load Product Dimension
-- =========================================================

INSERT INTO warehouse.dim_product (
    product_key,
    product_id,
    product_name,
    category,
    sub_category,
    unit_price,
    cost_price
)
SELECT
    ROW_NUMBER() OVER (ORDER BY product_id)::INTEGER,
    product_id,
    product_name,
    category,
    sub_category,
    unit_price,
    cost_price
FROM staging.stg_products;


-- =========================================================
-- 3. Load Store Dimension
-- =========================================================

INSERT INTO warehouse.dim_store (
    store_key,
    store_id,
    store_name,
    city,
    region
)
SELECT
    ROW_NUMBER() OVER (ORDER BY store_id)::INTEGER,
    store_id,
    store_name,
    city,
    region
FROM staging.stg_stores;


-- =========================================================
-- 4. Load Payment Method Dimension
-- =========================================================

INSERT INTO warehouse.dim_payment_method (
    payment_method_key,
    payment_method
)
SELECT
    ROW_NUMBER() OVER (ORDER BY payment_method)::INTEGER,
    payment_method
FROM (
    SELECT DISTINCT payment_method
    FROM staging.stg_transactions
    WHERE payment_method IS NOT NULL
) AS payment_methods;


-- =========================================================
-- 5. Load Date Dimension
-- =========================================================

INSERT INTO warehouse.dim_date (
    date_key,
    date,
    day,
    month,
    quarter,
    year
)
SELECT
    TO_CHAR(transaction_date, 'YYYYMMDD')::INTEGER,
    transaction_date,
    EXTRACT(DAY FROM transaction_date)::INTEGER,
    EXTRACT(MONTH FROM transaction_date)::INTEGER,
    EXTRACT(QUARTER FROM transaction_date)::INTEGER,
    EXTRACT(YEAR FROM transaction_date)::INTEGER
FROM (
    SELECT DISTINCT date AS transaction_date
    FROM staging.stg_transactions
    WHERE date IS NOT NULL
) AS transaction_dates;