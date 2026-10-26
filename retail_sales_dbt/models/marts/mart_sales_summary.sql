
-- Sales summary mart for reporting and Power BI.
-- One row per date, product, store, and payment method.

SELECT
    dd.date,
    dd.year,
    dd.quarter,
    dd.month,
    dp.product_id,
    dp.product_name,
    dp.category,
    ds.store_id,
    ds.store_name,
    ds.region,
    dpm.payment_method,
    COUNT(*) AS transaction_count,
    SUM(fs.quantity) AS units_sold,
    ROUND(AVG(fs.discount), 4) AS average_discount
FROM {{ ref('fact_sales') }} AS fs
JOIN {{ ref('dim_date') }} AS dd
    ON fs.date_key = dd.date_key
JOIN {{ ref('dim_product') }} AS dp
    ON fs.product_key = dp.product_key
JOIN {{ ref('dim_store') }} AS ds
    ON fs.store_key = ds.store_key
JOIN {{ ref('dim_payment_method') }} AS dpm
    ON fs.payment_method_key = dpm.payment_method_key
GROUP BY
    dd.date,
    dd.year,
    dd.quarter,
    dd.month,
    dp.product_id,
    dp.product_name,
    dp.category,
    ds.store_id,
    ds.store_name,
    ds.region,
    dpm.payment_method
