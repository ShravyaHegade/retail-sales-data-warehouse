
-- Payment method dimension for the retail sales warehouse.

SELECT
    ROW_NUMBER() OVER (ORDER BY payment_method) AS payment_method_key,
    payment_method
FROM (
    SELECT DISTINCT payment_method
    FROM {{ ref('stg_transactions') }}
    WHERE payment_method IS NOT NULL
) AS distinct_payment_methods
