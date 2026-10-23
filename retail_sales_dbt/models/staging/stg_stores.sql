
-- Clean store data from the RAW source.

SELECT
    TRIM(storeid) AS store_id,
    TRIM(storename) AS store_name,
    TRIM(city) AS city,
    TRIM(region) AS region
FROM {{ source('retail_raw', 'stores') }}
