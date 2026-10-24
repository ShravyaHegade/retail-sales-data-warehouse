
-- Customer dimension for the retail sales warehouse.

SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    customer_id,
    first_name,
    last_name,
    gender,
    birth_date,
    city,
    join_date
FROM {{ ref('stg_customers') }}
