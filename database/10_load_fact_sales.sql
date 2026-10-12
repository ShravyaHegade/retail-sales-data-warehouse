
-- Load sales transactions into the WAREHOUSE fact table.
-- This is an initial load and assumes the fact table is empty.

-- 1. Check that the fact table is empty and all staging
-- transactions can be matched to their dimension records.
DO $$
DECLARE
    staging_count BIGINT;
    matched_count BIGINT;
BEGIN
    IF EXISTS (
        SELECT 1
        FROM warehouse.fact_sales
    ) THEN
        RAISE EXCEPTION
            'Fact table is not empty. Load cancelled to prevent duplicates.';
    END IF;

    SELECT COUNT(*)
    INTO staging_count
    FROM staging.stg_transactions;

    SELECT COUNT(*)
    INTO matched_count
    FROM staging.stg_transactions s
    JOIN warehouse.dim_customer c
        ON s.customer_id = c.customer_id
    JOIN warehouse.dim_product p
        ON s.product_id = p.product_id
    JOIN warehouse.dim_store st
        ON s.store_id = st.store_id
    JOIN warehouse.dim_date d
        ON s.date = d.date
    JOIN warehouse.dim_payment_method pm
        ON s.payment_method = pm.payment_method;

    IF matched_count <> staging_count THEN
        RAISE EXCEPTION
            'Load cancelled: % staging transactions, but only % matched all dimensions.',
            staging_count, matched_count;
    END IF;
END $$;


-- 2. Insert sales records using warehouse surrogate keys.
INSERT INTO warehouse.fact_sales (
    sales_key,
    transaction_id,
    customer_key,
    product_key,
    store_key,
    date_key,
    payment_method_key,
    quantity,
    discount
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY s.transaction_id
    )::BIGINT AS sales_key,
    s.transaction_id,
    c.customer_key,
    p.product_key,
    st.store_key,
    d.date_key,
    pm.payment_method_key,
    s.quantity,
    s.discount
FROM staging.stg_transactions s
JOIN warehouse.dim_customer c
    ON s.customer_id = c.customer_id
JOIN warehouse.dim_product p
    ON s.product_id = p.product_id
JOIN warehouse.dim_store st
    ON s.store_id = st.store_id
JOIN warehouse.dim_date d
    ON s.date = d.date
JOIN warehouse.dim_payment_method pm
    ON s.payment_method = pm.payment_method;
