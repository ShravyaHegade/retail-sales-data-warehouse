-- Create STAGING tables for the retail sales data warehouse.
-- The STAGING layer prepares RAW data for warehouse transformations.


-- 1. Staging Customers
CREATE TABLE IF NOT EXISTS staging.stg_customers (
    customer_id TEXT,
    first_name TEXT,
    last_name TEXT,
    gender TEXT,
    birth_date DATE,
    city TEXT,
    join_date DATE
);


-- 2. Staging Products
CREATE TABLE IF NOT EXISTS staging.stg_products (
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    sub_category TEXT,
    unit_price NUMERIC,
    cost_price NUMERIC
);


-- 3. Staging Stores
CREATE TABLE IF NOT EXISTS staging.stg_stores (
    store_id TEXT,
    store_name TEXT,
    city TEXT,
    region TEXT
);


-- 4. Staging Transactions
CREATE TABLE IF NOT EXISTS staging.stg_transactions (
    transaction_id TEXT,
    date DATE,
    customer_id TEXT,
    product_id TEXT,
    store_id TEXT,
    quantity INTEGER,
    discount NUMERIC,
    payment_method TEXT
);