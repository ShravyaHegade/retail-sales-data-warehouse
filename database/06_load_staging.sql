-- Load standardized data from RAW into STAGING.

-- =========================================================
-- 1. Load Customers
-- =========================================================

INSERT INTO staging.stg_customers (
    customer_id,
    first_name,
    last_name,
    gender,
    birth_date,
    city,
    join_date
)
SELECT
    TRIM(customerid),
    TRIM(firstname),
    TRIM(lastname),
    TRIM(gender),
    birthdate,
    TRIM(city),
    joindate
FROM raw.customers;


-- =========================================================
-- 2. Load Products
-- =========================================================

INSERT INTO staging.stg_products (
    product_id,
    product_name,
    category,
    sub_category,
    unit_price,
    cost_price
)
SELECT
    TRIM(productid),
    TRIM(productname),
    TRIM(category),
    TRIM(subcategory),
    unitprice,
    costprice
FROM raw.products;


-- =========================================================
-- 3. Load Stores
-- =========================================================

INSERT INTO staging.stg_stores (
    store_id,
    store_name,
    city,
    region
)
SELECT
    TRIM(storeid),
    TRIM(storename),
    TRIM(city),
    TRIM(region)
FROM raw.stores;


-- =========================================================
-- 4. Load Transactions
-- =========================================================

INSERT INTO staging.stg_transactions (
    transaction_id,
    date,
    customer_id,
    product_id,
    store_id,
    quantity,
    discount,
    payment_method
)
SELECT
    TRIM(transactionid),
    date,
    TRIM(customerid),
    TRIM(productid),
    TRIM(storeid),
    quantity,
    discount,
    TRIM(paymentmethod)
FROM raw.transactions;