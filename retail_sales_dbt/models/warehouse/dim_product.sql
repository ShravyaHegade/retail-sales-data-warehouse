
-- Product dimension for the retail sales warehouse.

SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
    product_id,
    product_name,
    category,
    sub_category,
    unit_price,
    cost_price
FROM {{ ref('stg_products') }}
