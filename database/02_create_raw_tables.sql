-- Create RAW tables for the retail sales data warehouse.
-- The RAW layer stores data as received from the source CSV files.


-- 1. Customers
CREATE TABLE IF NOT EXISTS raw.customers (
    customerid TEXT,
    firstname TEXT,
    lastname TEXT,
    gender TEXT,
    birthdate DATE,
    city TEXT,
    joindate DATE
);


-- 2. Products
CREATE TABLE IF NOT EXISTS raw.products (
    productid TEXT,
    productname TEXT,
    category TEXT,
    subcategory TEXT,
    unitprice NUMERIC,
    costprice NUMERIC
);


-- 3. Stores
CREATE TABLE IF NOT EXISTS raw.stores (
    storeid TEXT,
    storename TEXT,
    city TEXT,
    region TEXT
);


-- 4. Transactions
CREATE TABLE IF NOT EXISTS raw.transactions (
    transactionid TEXT,
    date DATE,
    customerid TEXT,
    productid TEXT,
    storeid TEXT,
    quantity INTEGER,
    discount NUMERIC,
    paymentmethod TEXT
);