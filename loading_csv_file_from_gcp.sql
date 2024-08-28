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

-- Step 5: Create Storage Integration for GCP
CREATE STORAGE INTEGRATION my_gcp_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 'GCS'
    ENABLED = TRUE
    STORAGE_GCP_SERVICE_ACCOUNT_EMAIL = '<GCP_SERVICE_ACCOUNT_EMAIL>'
    STORAGE_ALLOWED_LOCATIONS = ('gcs://my_bucket/path_to_your_data/');

-- Step 6: Create External Stage for GCP Cloud Storage
CREATE STAGE my_gcp_stage
    URL = 'gcs://my_bucket/path_to_your_data/'
    STORAGE_INTEGRATION = my_gcp_integration
    FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

-- Step 7: Load Data into Table
COPY INTO my_database.my_schema.customer_csv
FROM @my_gcp_stage
ON_ERROR = 'CONTINUE';
