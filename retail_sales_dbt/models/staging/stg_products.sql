
-- Clean product data from the RAW source.

SELECT
    TRIM(productid) AS product_id,
    TRIM(productname) AS product_name,
    TRIM(category) AS category,
    TRIM(subcategory) AS sub_category,
    unitprice AS unit_price,
    costprice AS cost_price
FROM {{ source('retail_raw', 'products')}}
