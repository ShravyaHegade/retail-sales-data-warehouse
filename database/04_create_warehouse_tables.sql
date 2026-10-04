-- Create WAREHOUSE tables for the retail sales data warehouse.
-- The WAREHOUSE layer contains the dimensional model used for analytics.


-- 1. Customer Dimension
CREATE TABLE IF NOT EXISTS warehouse.dim_customer (
    customer_key INTEGER,
    customer_id TEXT,
    first_name TEXT,
    last_name TEXT,
    gender TEXT,
    birth_date DATE,
    city TEXT,
    join_date DATE
);


-- 2. Product Dimension
CREATE TABLE IF NOT EXISTS warehouse.dim_product (
    product_key INTEGER,
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    sub_category TEXT,
    unit_price NUMERIC,
    cost_price NUMERIC
);


-- 3. Store Dimension
CREATE TABLE IF NOT EXISTS warehouse.dim_store (
    store_key INTEGER,
    store_id TEXT,
    store_name TEXT,
    city TEXT,
    region TEXT
);


-- 4. Date Dimension
CREATE TABLE IF NOT EXISTS warehouse.dim_date (
    date_key INTEGER,
    date DATE,
    day INTEGER,
    month INTEGER,
    quarter INTEGER,
    year INTEGER
);


-- 5. Payment Method Dimension
CREATE TABLE IF NOT EXISTS warehouse.dim_payment_method (
    payment_method_key INTEGER,
    payment_method TEXT
);


-- 6. Sales Fact
CREATE TABLE IF NOT EXISTS warehouse.fact_sales (
    sales_key BIGINT,
    transaction_id TEXT,
    customer_key INTEGER,
    product_key INTEGER,
    store_key INTEGER,
    date_key INTEGER,
    payment_method_key INTEGER,
    quantity INTEGER,
    discount NUMERIC
);