# Retail Sales Data Warehouse

## Project Overview

This project focuses on building an end-to-end retail sales data warehouse using PostgreSQL and SQL.

The goal is to transform raw retail data into a structured analytical data model that can support business reporting, data analysis, and data-driven decision-making.

The project follows a layered data architecture:

    Source CSV Files
          |
          v
    PostgreSQL RAW
          |
          v
       STAGING
          |
          v
    DIMENSIONAL WAREHOUSE
          |
          v
    BUSINESS ANALYTICS / POWER BI

The project is being developed incrementally, with data ingestion, validation, transformation, dimensional modelling, and analytics implemented as separate stages.

**Project Status:** In Progress


## Project Objectives

- Ingest retail data from CSV files into PostgreSQL.
- Organize data using separate RAW, STAGING, and WAREHOUSE schemas.
- Validate incoming data before downstream processing.
- Develop SQL transformations to prepare data for analytics.
- Design a dimensional model using fact and dimension tables.
- Implement data quality and referential integrity checks.
- Build business intelligence dashboards using Power BI.
- Introduce dbt for managed transformations and automated testing.
- Explore workflow orchestration and containerization in later stages.


## Technology Stack

| Technology | Purpose | Status |
|---|---|---|
| PostgreSQL | Database and data warehouse | In use |
| SQL | Schema creation, data loading, transformations, and validation | In use |
| Git and GitHub | Version control and project documentation | In use |
| dbt | Managed transformations and automated data tests | Planned |
| Power BI | Business intelligence and dashboards | Planned |
| Apache Airflow | Workflow orchestration | Planned |
| Docker | Reproducible development environment | Planned |


## Data Source

The project uses a retail sales and customer insights dataset containing four main entities:

- **Customers:** Customer details and registration information.
- **Products:** Product names, categories, subcategories, prices, and costs.
- **Stores:** Store details, cities, and regions.
- **Transactions:** Transaction dates, customer and product references, store references, quantities, discounts, and payment methods.

The source dataset was obtained from Kaggle. Refer to the original dataset page for its source information and licensing details.


## Data Architecture

The project uses a layered data architecture within PostgreSQL.

    Source Dataset
          |
          v
      CSV Files
          |
          v
    +-------------------+
    |    RAW Schema     |
    |                   |
    |  Source-like data |
    +---------+---------+
              |
              | Data Validation
              v
    +-------------------+
    |  STAGING Schema   |
    |                   |
    | Standardization   |
    |  Transformations  |
    +---------+---------+
              |
              | Data Modelling
              v
    +-------------------+
    | WAREHOUSE Schema  |
    |                   |
    | Facts + Dimensions|
    +---------+---------+
              |
              v
      Business Analytics
              |
              v
          Power BI


### RAW Layer

The RAW layer stores data imported from the source CSV files with minimal transformation.

Tables:

- `raw.customers`
- `raw.products`
- `raw.stores`
- `raw.transactions`

RAW data validation includes checks for:

- Row counts
- NULL values in key fields
- Duplicate business IDs
- Referential integrity
- Quantity validity
- Discount validity
- Transaction date ranges
- Payment method distribution


### STAGING Layer

The STAGING layer prepares RAW data for the dimensional warehouse.

Transformations include:

- Standardized column naming
- Text trimming
- Consistent field naming conventions
- Preparation of source identifiers for warehouse loading

Tables:

- `staging.stg_customers`
- `staging.stg_products`
- `staging.stg_stores`
- `staging.stg_transactions`

STAGING validation includes:

- Row-count reconciliation
- NULL key checks
- Duplicate business ID checks
- Referential integrity checks
- Quantity validation
- Discount validation
- Transaction date validation
- Payment method validation


### WAREHOUSE Layer

The WAREHOUSE layer uses a dimensional model designed for analytical reporting.

#### Dimension Tables

- `warehouse.dim_customer`
- `warehouse.dim_product`
- `warehouse.dim_store`
- `warehouse.dim_date`
- `warehouse.dim_payment_method`

#### Fact Table

- `warehouse.fact_sales`

The intended grain of the sales fact table is:

> One row per product-level sales transaction for a customer at a store on a specific date.

Surrogate keys are used in the warehouse dimensions, while source identifiers are retained as business identifiers.


## Database Design

### Customer Dimension

`warehouse.dim_customer`

Contains customer attributes such as:

- Customer ID
- Name
- Gender
- Birth date
- City
- Join date


### Product Dimension

`warehouse.dim_product`

Contains product attributes such as:

- Product ID
- Product name
- Category
- Subcategory
- Unit price
- Cost price


### Store Dimension

`warehouse.dim_store`

Contains:

- Store ID
- Store name
- City
- Region


### Date Dimension

`warehouse.dim_date`

Provides calendar attributes for analytical reporting, including:

- Date
- Day
- Month
- Quarter
- Year


### Payment Method Dimension

`warehouse.dim_payment_method`

Stores standardized payment method values used by the sales fact table.


### Sales Fact

`warehouse.fact_sales`

Contains transaction-level measures and foreign keys to the relevant dimensions, including:

- Transaction ID
- Customer key
- Product key
- Store key
- Date key
- Payment method key
- Quantity
- Discount


## Data Quality Approach

Data quality checks are implemented as part of the SQL pipeline rather than as a separate standalone data-cleaning exercise.

The current validation approach checks:

### Completeness

- Expected row counts
- NULL values in important identifiers

### Uniqueness

- Duplicate customer IDs
- Duplicate product IDs
- Duplicate store IDs
- Duplicate transaction IDs

### Referential Integrity

Transactions are checked against:

- Customers
- Products
- Stores

### Validity

Business rules are used to validate:

- Quantity values
- Discount values
- Transaction dates
- Payment methods

### Reconciliation

RAW and STAGING row counts and key distributions are compared to ensure that transformations do not unexpectedly lose or duplicate records.


## Current Progress

### Completed

- [x] Created the PostgreSQL database.
- [x] Created the `raw`, `staging`, and `warehouse` schemas.
- [x] Created RAW table structures.
- [x] Created STAGING table structures.
- [x] Created WAREHOUSE table structures.
- [x] Exported the source workbook sheets into individual CSV files.
- [x] Imported customer data into `raw.customers`.
- [x] Imported product data into `raw.products`.
- [x] Imported store data into `raw.stores`.
- [x] Imported transaction data into `raw.transactions`.
- [x] Validated RAW row counts.
- [x] Validated RAW business key uniqueness.
- [x] Validated RAW NULL key values.
- [x] Validated transaction references to customers.
- [x] Validated transaction references to products.
- [x] Validated transaction references to stores.
- [x] Validated transaction quantities.
- [x] Validated transaction discounts.
- [x] Validated transaction date range.
- [x] Validated payment method distribution.
- [x] Loaded customers into STAGING.
- [x] Loaded products into STAGING.
- [x] Loaded stores into STAGING.
- [x] Loaded transactions into STAGING.
- [x] Validated STAGING row counts.
- [x] Validated STAGING NULL key values.
- [x] Validated STAGING business key uniqueness.
- [x] Validated STAGING referential integrity.
- [x] Validated STAGING quantities and discounts.
- [x] Validated STAGING transaction dates.
- [x] Validated STAGING payment methods.
- [x] Added database SQL scripts to GitHub.


### In Progress

- [ ] Finalize the STAGING validation SQL script.
- [ ] Load and validate warehouse dimension tables.
- [ ] Populate the date dimension.
- [ ] Populate the sales fact table.
- [ ] Validate the dimensional warehouse.
- [ ] Build analytical SQL queries and data marts.


### Planned

- [ ] Introduce dbt for transformations and automated testing.
- [ ] Build Power BI dashboards.
- [ ] Add workflow orchestration with Apache Airflow.
- [ ] Containerize the project using Docker.
- [ ] Explore cloud deployment options.
- [ ] Add pipeline monitoring and observability.


## SQL Pipeline

The SQL scripts are organized in execution order:

    database/
    ├── 01_create_schemas.sql
    ├── 02_create_raw_tables.sql
    ├── 03_create_staging_tables.sql
    ├── 04_create_warehouse_tables.sql
    ├── 05_validate_raw_data.sql
    ├── 06_load_staging.sql
    └── 07_validate_staging.sql

The pipeline currently follows:

    Create Database Structure
              |
              v
         Load RAW Data
              |
              v
       Validate RAW Data
              |
              v
       Load STAGING Data
              |
              v
      Validate STAGING Data
              |
              v
       Build Warehouse Model


## Planned Business Analysis

The completed warehouse is intended to support analysis such as:

- Sales trends over time.
- Sales by product category and subcategory.
- Sales by store, city, and region.
- Transaction volume by payment method.
- Customer purchasing patterns.
- Quantity and discount analysis.
- Product performance.
- Store performance.
- Customer segmentation and purchasing behaviour.

Revenue and profit analysis will depend on the availability of reliable transaction-level pricing data.


## Data Limitations

The transaction data contains quantities and discounts but does not contain a transaction-level snapshot of the unit price or cost price at the time of each sale.

The product dataset contains unit prices and cost prices, but these values may represent product-level prices rather than historical prices at the time of each transaction.

Therefore, historical revenue and profit should **not** be treated as fully accurate unless transaction-level pricing data or documented pricing assumptions are introduced.

This limitation will be explicitly considered when developing analytical metrics and dashboards.


## Repository Structure

    retail-sales-data-warehouse/
    │
    ├── README.md
    ├── .gitignore
    │
    ├── database/
    │   ├── 01_create_schemas.sql
    │   ├── 02_create_raw_tables.sql
    │   ├── 03_create_staging_tables.sql
    │   ├── 04_create_warehouse_tables.sql
    │   ├── 05_validate_raw_data.sql
    │   ├── 06_load_staging.sql
    │   └── 07_validate_staging.sql
    │
    ├── docs/
    │   ├── architecture.png
    │   └── data_dictionary.md
    │
    ├── dbt/                    # Planned
    │
    └── power-bi/               # Planned

The repository structure will evolve as additional components such as dbt, Power BI, Airflow, and Docker are introduced.


## Getting Started

### Prerequisites

Install:

- PostgreSQL
- Git

Additional tools such as dbt, Power BI, Docker, and Apache Airflow will be introduced in later stages.


### Setup

1. Clone this repository.
2. Create a PostgreSQL database named `retail_dw`.
3. Execute the database creation scripts in order.
4. Export the source workbook sheets to CSV files.
5. Import the CSV files into the corresponding RAW tables.
6. Run the RAW validation script.
7. Run the STAGING load script.
8. Run the STAGING validation checks.
9. Continue with the warehouse loading scripts as they are developed.

Detailed setup and execution instructions will be expanded as the project progresses.


## Project Goal

The goal of this project is to demonstrate practical data engineering skills through the development of an end-to-end analytical data pipeline.

Key areas demonstrated include:

- PostgreSQL database development
- SQL development
- Layered data architecture
- Data ingestion
- Data quality validation
- Data transformation
- Referential integrity
- Dimensional modelling
- Fact and dimension design
- Git and GitHub version control
- Analytical data preparation
- Business intelligence

Future stages will extend the project with dbt, Power BI, workflow orchestration, containerization, and potentially cloud-based deployment.
