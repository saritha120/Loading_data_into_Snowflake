# Loading_data_into_Snowflake
Data Ingestion with COPY INTO in Snowflake (Local File, AWS, Azure, GCP)

Loading a CSV file from the local file system.
Loading multiple CSV files from the local file system.
Loading a CSV file from AWS S3 bucket.
Loading a CSV file from Azure Data Lake Gen 2 storage.
Loading a CSV file from GCP Cloud storage.
Loading a JSON file from the local file system.
Loading a Parquet file from the local file system.

Prerequisites:
Snowflake Enterprise account
SnowSQL CLI
Sample data file

Scenario 1: Loading a Single CSV File from Local File System
Steps:
Create a custom role and virtual warehouse.
Create a database, schema, and table.
Create a file format (optional for CSV) and named stage.
Use the PUT command in SnowSQL to stage the data.
Use the COPY INTO command to load data into the table.

Scenario 2: Loading Multiple CSV Files from Local File System
Steps:
Modify Script for Multiple Files.
Adapt the previous script to handle multiple files by using pattern matching in the COPY INTO command.
Monitor Data Loading:
Use the PURGE parameter to remove staged files post-loading, reducing storage costs.
Query the loaded data to ensure accuracy.

Scenario 3: Loading a CSV File from AWS S3 Bucket
Steps:
Set Up Storage Integration.
Configure a Snowflake Storage Integration to securely access AWS S3 buckets.
This one-time setup provides secure access for reading and writing files from S3.
Stage and Load Data:
After setting up the integration, stage the files using the external stage and load them into Snowflake tables.

Scenario 4: Loading a CSV File from Azure Data Lake Gen 2 Storage
Steps:
Create Azure Storage Integration.
Similar to AWS S3, configure a Snowflake Storage Integration for Azure blob storage.
Load Data:
Use the COPY INTO command to load data from the Azure storage container into Snowflake tables.

Scenario 5: Loading a CSV File from GCP Cloud Storage
Steps:
Set Up GCP Storage Integration:
Follow the same process as AWS S3 and Azure for setting up a storage integration with Google Cloud Storage.
Stage and Load Data:
Load data using the COPY INTO command with the appropriate file formats and storage integration.

Scenario 6: Load JSON File from Local File System (Single File)
Steps:
Create a JSON file format and named stage.
Use the PUT command in SnowSQL to stage the JSON data.
Use the COPY INTO command to load the JSON data into the table.

Scenario 7: Load Parquet File from Local File System (Single File)
Steps:
Create a Parquet file format and named stage.
Use the PUT command in SnowSQL to stage the Parquet data.
Use the COPY INTO command to load the Parquet data into the table.
