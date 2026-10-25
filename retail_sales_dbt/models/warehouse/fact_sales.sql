
-- Sales fact table for the retail sales warehouse.
-- Grain: one row per transaction.

SELECT
    ROW_NUMBER() OVER (ORDER BY t.transaction_id) AS sales_key,
    t.transaction_id,
    dc.customer_key,
    dp.product_key,
    ds.store_key,
    dd.date_key,
    dpm.payment_method_key,
    t.quantity,
    t.discount
FROM {{ ref('stg_transactions') }} AS t
LEFT JOIN {{ ref('dim_customers') }} AS dc
    ON t.customer_id = dc.customer_id
LEFT JOIN {{ ref('dim_product') }} AS dp
    ON t.product_id = dp.product_id
LEFT JOIN {{ ref('dim_store') }} AS ds
    ON t.store_id = ds.store_id
LEFT JOIN {{ ref('dim_date') }} AS dd
    ON t.transaction_date = dd.date
LEFT JOIN {{ ref('dim_payment_method') }} AS dpm
    ON t.payment_method = dpm.payment_method
