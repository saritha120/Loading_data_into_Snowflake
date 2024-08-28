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
CREATE TABLE my_database.my_schema.customer_csv (
    id INT,
    name STRING,
    age INT,
    email STRING
);

-- Step 5: Create Named Stage (Internal)
CREATE STAGE my_stage;

-- Step 6: Create File Format (Optional for CSV)
CREATE FILE FORMAT my_csv_format
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1;

-- Step 7: Use SnowSQL to Stage Data
-- Run the following command in SnowSQL CLI:
-- snowsql -a <organization_name>-<account_name> -u <username> -p

-- Stage the data using PUT command
PUT file:///path_to_your_file/customers.csv @my_stage AUTO_COMPRESS=TRUE;

-- Step 8: Load Data into Table
COPY INTO my_database.my_schema.customer_csv
FROM @my_stage
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'CONTINUE';
