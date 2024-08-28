-- Step 1: Create a Role
CREATE ROLE DATA_LOADER;

-- Step 2: Grant Privileges
GRANT USAGE ON DATABASE my_database TO ROLE DATA_LOADER;
GRANT USAGE ON SCHEMA my_database.my_schema TO ROLE DATA_LOADER;
GRANT CREATE TABLE ON SCHEMA my_database.my_schema TO ROLE DATA_LOADER;

-- Step 3: Create a Virtual Warehouse
CREATE WAREHOUSE my_warehouse WITH WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;

-- Step 4: Create Database, Schema, and Table
CREATE DATABASE my_database;
CREATE SCHEMA my_database.my_schema;
CREATE TABLE my_database.my_schema.customer_parquet (
    id INT,
    name STRING,
    age INT,
    email STRING
);

-- Step 5: Create Named Stage (Internal)
CREATE STAGE my_stage;

-- Step 6: Create Parquet File Format
CREATE FILE FORMAT my_parquet_format
    TYPE = 'PARQUET';

-- Step 7: Use SnowSQL to Stage Data
-- Stage the data using PUT command
PUT file:///path_to_your_file/customers.parquet @my_stage AUTO_COMPRESS=TRUE;

-- Step 8: Load Data into Table
COPY INTO my_database.my_schema.customer_parquet
FROM @my_stage
FILE_FORMAT = (FORMAT_NAME = 'my_parquet_format')
ON_ERROR = 'CONTINUE';
