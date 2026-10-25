
-- Date dimension for the retail sales warehouse.
-- Creates one row for each distinct transaction date.

SELECT
    ROW_NUMBER() OVER (ORDER BY transaction_date) AS date_key,
    transaction_date AS date,
    EXTRACT(DAY FROM transaction_date)::INTEGER AS day,
    EXTRACT(MONTH FROM transaction_date)::INTEGER AS month,
    EXTRACT(QUARTER FROM transaction_date)::INTEGER AS quarter,
    EXTRACT(YEAR FROM transaction_date)::INTEGER AS year
FROM (
    SELECT DISTINCT transaction_date
    FROM {{ ref('stg_transactions') }}
    WHERE transaction_date IS NOT NULL
) AS distinct_dates
