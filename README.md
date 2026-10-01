# Retail Sales Data Warehouse

## Project Overview

This project focuses on building a retail sales data warehouse using PostgreSQL and SQL. The goal is to transform raw retail data into a structured analytical model that can support business reporting and data-driven decision-making.

The project follows a layered data architecture consisting of raw data ingestion, staging transformations, and a dimensional warehouse model. Future stages will include automated data quality testing, business intelligence dashboards, and pipeline orchestration.

**Project Status:** In Progress

## Project Objectives

- Ingest retail data from CSV files into PostgreSQL.
- Organize data using separate RAW, staging, and warehouse schemas.
- Develop SQL transformations to prepare data for analytics.
- Design a dimensional model using fact and dimension tables.
- Implement data quality checks and validation queries.
- Build business intelligence dashboards using Power BI.
- Explore pipeline automation and orchestration in later stages.

## Technology Stack

| Technology | Purpose | Status |
|---|---|---|
| PostgreSQL | Database and data warehouse | In use |
| SQL | Schema creation, transformations, and validation | In use |
| Git and GitHub | Version control and project documentation | In use |
| dbt | Managed transformations and data tests | Planned |
| Power BI | Business intelligence and dashboards | Planned |
| Apache Airflow | Workflow orchestration | Planned |
| Docker | Reproducible development environment | Planned |

## Data Source

The project uses a retail sales and customer insights dataset containing four data entities:

- **Customers:** Customer details and registration information.
- **Products:** Product names, categories, subcategories, prices, and costs.
- **Stores:** Store details, cities, and regions.
- **Transactions:** Transaction dates, customer and product references, store references, quantities, discounts, and payment methods.

The source dataset was obtained from Kaggle. Refer to the original dataset page for its source information and licensing details.

## Data Architecture

The planned architecture is:

```text
Source CSV Files
      |
      v
PostgreSQL RAW Schema
      |
      v
Staging Schema
      |
      v
Dimensional Warehouse
      |
      v
Power BI Reports
```

The RAW layer stores the ingested source data. The staging layer provides a place for standardized and validated data. The warehouse layer is designed for analytical queries using fact and dimension tables.

## Database Design

The PostgreSQL database is organized into three schemas.

### 1. RAW Schema

Contains the source data imported from CSV files.

- `raw.customers`
- `raw.products`
- `raw.stores`
- `raw.transactions`

### 2. Staging Schema

Contains tables intended for standardized data and SQL transformations.

- `staging.stg_customers`
- `staging.stg_products`
- `staging.stg_stores`
- `staging.stg_transactions`

### 3. Warehouse Schema

Contains the dimensional model designed for analytical reporting.

**Dimension tables**
- `warehouse.dim_customer`
- `warehouse.dim_product`
- `warehouse.dim_store`
- `warehouse.dim_date`
- `warehouse.dim_payment_method`

**Fact table**
- `warehouse.fact_sales`

The intended grain of the fact table is one row per product-level sales transaction.

## Current Progress

- [x] Created the PostgreSQL database.
- [x] Created the RAW, staging, and warehouse schemas.
- [x] Created the initial table structures.
- [x] Exported the source workbook sheets into individual CSV files.
- [x] Imported the customer, product, store, and transaction CSV files into the RAW schema.
- [ ] Validate imported row counts and data types.
- [ ] Develop staging transformations and data quality checks.
- [ ] Populate the dimensional warehouse.
- [ ] Implement automated transformation tests.
- [ ] Build Power BI dashboards.
- [ ] Explore workflow orchestration and containerization.

## Planned Business Analysis

The completed warehouse is intended to support analysis such as:

- Sales trends over time.
- Sales by product category and subcategory.
- Sales by store, city, and region.
- Transaction volume by payment method.
- Customer purchasing patterns.
- Quantity and discount analysis.

The availability and accuracy of revenue and profit metrics will depend on the source data and the pricing assumptions used.

## Data Limitations

The transaction data contains quantities and discounts but does not include a transaction-level snapshot of the unit price or cost price at the time of each sale.

The product dataset contains unit prices and cost prices, but these may represent current product values rather than historical transaction values. Therefore, historical revenue and profit should not be treated as fully accurate unless appropriate transaction-level pricing data or documented assumptions are available.

## Repository Structure

```text
retail-sales-data-warehouse/
├── README.md
├── .gitignore
├── sql/
│   ├── 01_create_schemas.sql
│   ├── 02_create_raw_tables.sql
│   ├── 03_create_staging_tables.sql
│   ├── 04_create_warehouse_tables.sql
│   └── 05_validate_raw_data.sql
├── docs/
│   ├── architecture.png
│   └── data_dictionary.md
├── dbt/                 # Planned
└── power-bi/            # Planned

The repository structure will evolve as the project develops.

## Getting Started

1. Install PostgreSQL.
2. Clone this repository.
3. Create a PostgreSQL database named `retail_dw`.
4. Execute the SQL scripts in the appropriate order.
5. Export the source workbook sheets to CSV files.
6. Import the CSV files into the corresponding RAW tables.
7. Run the validation queries to check the imported data.

Detailed setup and execution instructions will be expanded as the pipeline develops.

## Project Goal

The goal is to demonstrate practical data engineering skills, including relational database design, SQL development, data validation, dimensional modelling, version control, and the development of an analytical data pipeline.