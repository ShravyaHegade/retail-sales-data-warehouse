-- Validate data loaded into the STAGING layer.
-- These checks verify row counts, NULL values, duplicate business IDs,
-- referential integrity, and basic business rules.


-- =========================================================
-- 1. Row Counts
-- =========================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM staging.stg_customers

UNION ALL

SELECT 'products', COUNT(*)
FROM staging.stg_products

UNION ALL

SELECT 'stores', COUNT(*)
FROM staging.stg_stores

UNION ALL

SELECT 'transactions', COUNT(*)
FROM staging.stg_transactions;


-- =========================================================
-- 2. Check for NULL values in key fields
-- =========================================================

SELECT
    'customers' AS table_name,
    COUNT(*) FILTER (
        WHERE customer_id IS NULL
    ) AS null_ids
FROM staging.stg_customers

UNION ALL

SELECT
    'products',
    COUNT(*) FILTER (
        WHERE product_id IS NULL
    )
FROM staging.stg_products

UNION ALL

SELECT
    'stores',
    COUNT(*) FILTER (
        WHERE store_id IS NULL
    )
FROM staging.stg_stores

UNION ALL

SELECT
    'transactions',
    COUNT(*) FILTER (
        WHERE transaction_id IS NULL
    )
FROM staging.stg_transactions;


-- =========================================================
-- 3. Check for duplicate business IDs
-- =========================================================

SELECT
    customer_id,
    COUNT(*) AS record_count
FROM staging.stg_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT
    product_id,
    COUNT(*) AS record_count
FROM staging.stg_products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT
    store_id,
    COUNT(*) AS record_count
FROM staging.stg_stores
GROUP BY store_id
HAVING COUNT(*) > 1;

SELECT
    transaction_id,
    COUNT(*) AS record_count
FROM staging.stg_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;


-- =========================================================
-- 4. Check transaction references
--    against customers, products, and stores
-- =========================================================

SELECT COUNT(*) AS invalid_customer_references
FROM staging.stg_transactions t
LEFT JOIN staging.stg_customers c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS invalid_product_references
FROM staging.stg_transactions t
LEFT JOIN staging.stg_products p
    ON t.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS invalid_store_references
FROM staging.stg_transactions t
LEFT JOIN staging.stg_stores s
    ON t.store_id = s.store_id
WHERE s.store_id IS NULL;


-- =========================================================
-- 5. Validate transaction quantity
-- =========================================================

SELECT COUNT(*) AS invalid_quantity_records
FROM staging.stg_transactions
WHERE quantity <= 0;


-- =========================================================
-- 6. Validate transaction discount
-- =========================================================

SELECT COUNT(*) AS invalid_discount_records
FROM staging.stg_transactions
WHERE discount < 0
   OR discount > 0.15;


-- =========================================================
-- 7. Validate transaction date range
-- =========================================================

SELECT
    MIN(date) AS minimum_transaction_date,
    MAX(date) AS maximum_transaction_date
FROM staging.stg_transactions;


-- =========================================================
-- 8. Payment method distribution
-- =========================================================

SELECT
    payment_method,
    COUNT(*) AS transaction_count
FROM staging.stg_transactions
GROUP BY payment_method
ORDER BY transaction_count DESC;