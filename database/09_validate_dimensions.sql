-- Validate dimension tables in the WAREHOUSE layer.
-- These checks verify row counts, NULL keys, duplicate keys,
-- duplicate business IDs, and consistency with STAGING.


-- =========================================================
-- 1. Dimension Row Counts
-- =========================================================

SELECT 'dim_customer' AS table_name, COUNT(*) AS row_count
FROM warehouse.dim_customer

UNION ALL

SELECT 'dim_product', COUNT(*)
FROM warehouse.dim_product

UNION ALL

SELECT 'dim_store', COUNT(*)
FROM warehouse.dim_store

UNION ALL

SELECT 'dim_date', COUNT(*)
FROM warehouse.dim_date

UNION ALL

SELECT 'dim_payment_method', COUNT(*)
FROM warehouse.dim_payment_method;


-- =========================================================
-- 2. Check for NULL Surrogate Keys
-- Expected: 0 for every dimension
-- =========================================================

SELECT 'dim_customer' AS table_name, COUNT(*) AS null_key_count
FROM warehouse.dim_customer
WHERE customer_key IS NULL

UNION ALL

SELECT 'dim_product', COUNT(*)
FROM warehouse.dim_product
WHERE product_key IS NULL

UNION ALL

SELECT 'dim_store', COUNT(*)
FROM warehouse.dim_store
WHERE store_key IS NULL

UNION ALL

SELECT 'dim_date', COUNT(*)
FROM warehouse.dim_date
WHERE date_key IS NULL

UNION ALL

SELECT 'dim_payment_method', COUNT(*)
FROM warehouse.dim_payment_method
WHERE payment_method_key IS NULL;


-- =========================================================
-- 3. Check for Duplicate Surrogate Keys
-- Expected: No rows returned by each query
-- =========================================================

SELECT customer_key, COUNT(*) AS record_count
FROM warehouse.dim_customer
GROUP BY customer_key
HAVING COUNT(*) > 1;

SELECT product_key, COUNT(*) AS record_count
FROM warehouse.dim_product
GROUP BY product_key
HAVING COUNT(*) > 1;

SELECT store_key, COUNT(*) AS record_count
FROM warehouse.dim_store
GROUP BY store_key
HAVING COUNT(*) > 1;

SELECT date_key, COUNT(*) AS record_count
FROM warehouse.dim_date
GROUP BY date_key
HAVING COUNT(*) > 1;

SELECT payment_method_key, COUNT(*) AS record_count
FROM warehouse.dim_payment_method
GROUP BY payment_method_key
HAVING COUNT(*) > 1;


-- =========================================================
-- 4. Check for Duplicate Business IDs
-- Expected: No rows returned by each query
-- =========================================================

SELECT customer_id, COUNT(*) AS record_count
FROM warehouse.dim_customer
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS record_count
FROM warehouse.dim_product
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT store_id, COUNT(*) AS record_count
FROM warehouse.dim_store
GROUP BY store_id
HAVING COUNT(*) > 1;

SELECT date, COUNT(*) AS record_count
FROM warehouse.dim_date
GROUP BY date
HAVING COUNT(*) > 1;

SELECT payment_method, COUNT(*) AS record_count
FROM warehouse.dim_payment_method
GROUP BY payment_method
HAVING COUNT(*) > 1;


-- =========================================================
-- 5. Check Customer References Against STAGING
-- Expected: 0 missing customer IDs
-- =========================================================

SELECT COUNT(*) AS missing_customers_in_dimension
FROM staging.stg_customers s
LEFT JOIN warehouse.dim_customer d
    ON s.customer_id = d.customer_id
WHERE s.customer_id IS NOT NULL
  AND d.customer_id IS NULL;


-- =========================================================
-- 6. Check Product References Against STAGING
-- Expected: 0 missing product IDs
-- =========================================================

SELECT COUNT(*) AS missing_products_in_dimension
FROM staging.stg_products s
LEFT JOIN warehouse.dim_product d
    ON s.product_id = d.product_id
WHERE s.product_id IS NOT NULL
  AND d.product_id IS NULL;


-- =========================================================
-- 7. Check Store References Against STAGING
-- Expected: 0 missing store IDs
-- =========================================================

SELECT COUNT(*) AS missing_stores_in_dimension
FROM staging.stg_stores s
LEFT JOIN warehouse.dim_store d
    ON s.store_id = d.store_id
WHERE s.store_id IS NOT NULL
  AND d.store_id IS NULL;


-- =========================================================
-- 8. Check Transaction Dates Against Date Dimension
-- Expected: 0 missing dates
-- =========================================================

SELECT COUNT(DISTINCT s.date) AS missing_transaction_dates
FROM staging.stg_transactions s
LEFT JOIN warehouse.dim_date d
    ON s.date = d.date
WHERE s.date IS NOT NULL
  AND d.date IS NULL;


-- =========================================================
-- 9. Check Payment Methods Against STAGING
-- Expected: 0 missing payment methods
-- =========================================================

SELECT COUNT(DISTINCT s.payment_method) AS missing_payment_methods
FROM staging.stg_transactions s
LEFT JOIN warehouse.dim_payment_method d
    ON s.payment_method = d.payment_method
WHERE s.payment_method IS NOT NULL
  AND d.payment_method IS NULL;


-- =========================================================
-- 10. Check Product Prices
-- Expected: 0 invalid records
-- =========================================================

SELECT COUNT(*) AS invalid_product_price_records
FROM warehouse.dim_product
WHERE unit_price < 0
   OR cost_price < 0;