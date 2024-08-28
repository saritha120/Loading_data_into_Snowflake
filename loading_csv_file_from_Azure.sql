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

-- Step 5: Create Storage Integration for Azure
CREATE STORAGE INTEGRATION my_azure_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 'AZURE'
    ENABLED = TRUE
    STORAGE_AZURE_TENANT_ID = '<AZURE_TENANT_ID>'
    STORAGE_AZURE_CLIENT_ID = '<AZURE_CLIENT_ID>'
    STORAGE_AZURE_CLIENT_SECRET = '<AZURE_CLIENT_SECRET>'
    STORAGE_ALLOWED_LOCATIONS = ('azure://my_storage_account.blob.core.windows.net/my_container/path_to_your_data/');

-- Step 6: Create External Stage for Azure Blob Storage
CREATE STAGE my_azure_stage
    URL = 'azure://my_storage_account.blob.core.windows.net/my_container/path_to_your_data/'
    STORAGE_INTEGRATION = my_azure_integration
    FILE_FORMAT = (FORMAT_NAME = 'my_csv_format');

-- Step 7: Load Data into Table
COPY INTO my_database.my_schema.customer_csv
FROM @my_azure_stage
ON_ERROR = 'CONTINUE';
