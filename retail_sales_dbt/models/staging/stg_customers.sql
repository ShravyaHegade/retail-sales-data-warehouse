-- Standardize customer data from the RAW source.

SELECT
    TRIM(customerid) AS customer_id,
    TRIM(firstname) AS first_name,
    TRIM(lastname) AS last_name,
    TRIM(gender) AS gender,
    birthdate AS birth_date,
    TRIM(city) AS city,
    joindate AS join_date
FROM {{ source('retail_raw', 'customers')}}