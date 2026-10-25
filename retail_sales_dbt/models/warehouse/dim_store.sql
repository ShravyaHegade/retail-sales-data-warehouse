-- Store dimension for the retail sales warehouse.

SELECT 
    ROW_NUMBER() OVER (ORDER BY store_id) AS store_key,
    store_id,
    store_name,
    city,
    region
    FROM {{ ref('stg_stores')}}