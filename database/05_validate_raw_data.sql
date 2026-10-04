-- Validate data loaded into the RAW layer.
-- These checks verify row counts, duplicates, nulls,
-- referential integrity, and basic value ranges.


-- =========================================================
-- 1. Row Counts
-- =========================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM raw.customers

UNION ALL

SELECT 'products', COUNT(*)
FROM raw.products

UNION ALL

SELECT 'stores', COUNT(*)
FROM raw.stores

UNION ALL

SELECT 'transactions', COUNT(*)
FROM raw.transactions;


-- =========================================================
-- 2. Check for NULL values in key fields
-- =========================================================

SELECT
    'customers' AS table_name,
    COUNT(*) FILTER (
        WHERE customerid IS NULL
    ) AS null_customer_ids
FROM raw.customers

UNION ALL

SELECT
    'products',
    COUNT(*) FILTER (
        WHERE productid IS NULL
    )
FROM raw.products

UNION ALL

SELECT
    'stores',
    COUNT(*) FILTER (
        WHERE storeid IS NULL
    )
FROM raw.stores

UNION ALL

SELECT
    'transactions',
    COUNT(*) FILTER (
        WHERE transactionid IS NULL
    )
FROM raw.transactions;


-- =========================================================
-- 3. Check for duplicate business IDs
-- =========================================================

SELECT
    customerid,
    COUNT(*) AS record_count
FROM raw.customers
GROUP BY customerid
HAVING COUNT(*) > 1;


SELECT
    productid,
    COUNT(*) AS record_count
FROM raw.products
GROUP BY productid
HAVING COUNT(*) > 1;


SELECT
    storeid,
    COUNT(*) AS record_count
FROM raw.stores
GROUP BY storeid
HAVING COUNT(*) > 1;


SELECT
    transactionid,
    COUNT(*) AS record_count
FROM raw.transactions
GROUP BY transactionid
HAVING COUNT(*) > 1;


-- =========================================================
-- 4. Check transaction references
--    against customers, products, and stores
-- =========================================================

SELECT COUNT(*) AS invalid_customer_references
FROM raw.transactions t
LEFT JOIN raw.customers c
    ON t.customerid = c.customerid
WHERE c.customerid IS NULL;


SELECT COUNT(*) AS invalid_product_references
FROM raw.transactions t
LEFT JOIN raw.products p
    ON t.productid = p.productid
WHERE p.productid IS NULL;


SELECT COUNT(*) AS invalid_store_references
FROM raw.transactions t
LEFT JOIN raw.stores s
    ON t.storeid = s.storeid
WHERE s.storeid IS NULL;


-- =========================================================
-- 5. Validate quantity
-- =========================================================

SELECT COUNT(*) AS invalid_quantity_records
FROM raw.transactions
WHERE quantity <= 0;


-- =========================================================
-- 6. Validate discount
-- =========================================================

SELECT COUNT(*) AS invalid_discount_records
FROM raw.transactions
WHERE discount < 0
   OR discount > 0.15;


-- =========================================================
-- 7. Transaction date range
-- =========================================================

SELECT
    MIN(date) AS minimum_transaction_date,
    MAX(date) AS maximum_transaction_date
FROM raw.transactions;


-- =========================================================
-- 8. Payment method distribution
-- =========================================================

SELECT
    paymentmethod,
    COUNT(*) AS transaction_count
FROM raw.transactions
GROUP BY paymentmethod
ORDER BY transaction_count DESC;