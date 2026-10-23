
-- Clean transaction data from the RAW source.

SELECT
    TRIM(transactionid) AS transaction_id,
    "date" AS transaction_date,
    TRIM(customerid) AS customer_id,
    TRIM(productid) AS product_id,
    TRIM(storeid) AS store_id,
    quantity,
    discount,
    TRIM(paymentmethod) AS payment_method
FROM {{ source('retail_raw', 'transactions') }}
