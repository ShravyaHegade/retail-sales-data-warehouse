
-- Validate the sales fact table.
-- Expected initial load: 5,000 records.

-- 1. Check total fact records.
SELECT COUNT(*) AS total_sales_records
FROM warehouse.fact_sales;

-- 2. Check for NULL values in required columns.
SELECT
    COUNT(*) FILTER (WHERE sales_key IS NULL) AS null_sales_keys,
    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS null_transaction_ids,
    COUNT(*) FILTER (WHERE customer_key IS NULL) AS null_customer_keys,
    COUNT(*) FILTER (WHERE product_key IS NULL) AS null_product_keys,
    COUNT(*) FILTER (WHERE store_key IS NULL) AS null_store_keys,
    COUNT(*) FILTER (WHERE date_key IS NULL) AS null_date_keys,
    COUNT(*) FILTER (WHERE payment_method_key IS NULL) AS null_payment_keys
FROM warehouse.fact_sales;

-- 3. Check duplicate sales keys.
SELECT sales_key, COUNT(*) AS record_count
FROM warehouse.fact_sales
GROUP BY sales_key
HAVING COUNT(*) > 1;

-- 4. Check duplicate transaction IDs.
SELECT transaction_id, COUNT(*) AS record_count
FROM warehouse.fact_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- 5. Check for invalid dimension-key references.
SELECT COUNT(*) AS invalid_customer_references
FROM warehouse.fact_sales f
LEFT JOIN warehouse.dim_customer d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL;

SELECT COUNT(*) AS invalid_product_references
FROM warehouse.fact_sales f
LEFT JOIN warehouse.dim_product d
    ON f.product_key = d.product_key
WHERE d.product_key IS NULL;

SELECT COUNT(*) AS invalid_store_references
FROM warehouse.fact_sales f
LEFT JOIN warehouse.dim_store d
    ON f.store_key = d.store_key
WHERE d.store_key IS NULL;

SELECT COUNT(*) AS invalid_date_references
FROM warehouse.fact_sales f
LEFT JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
WHERE d.date_key IS NULL;

SELECT COUNT(*) AS invalid_payment_references
FROM warehouse.fact_sales f
LEFT JOIN warehouse.dim_payment_method d
    ON f.payment_method_key = d.payment_method_key
WHERE d.payment_method_key IS NULL;

-- 6. Check for invalid quantities and discounts.
SELECT COUNT(*) AS invalid_sales_records
FROM warehouse.fact_sales
WHERE quantity <= 0
   OR discount < 0
   OR discount > 1;
