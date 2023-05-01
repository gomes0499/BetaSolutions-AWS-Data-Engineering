from awsglue.transforms import *
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql import SparkSession
import re

# Name of the Source and Target S3 Buckets
source_bucket = "datalake/raw"
target_bucket = "datalake/processed"

# Initialize Spark and Glue contexts
sc = SparkContext.getOrCreate()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)

# Process each table
tables = ['categories', 'customers', 'products', 'orders', 'order_items']

for table in tables:
    # Read CSV files for the specific table from the source S3 bucket
    source_path = f"s3://{source_bucket}/{table}/*.csv"
    df = spark.read.csv(source_path, inferSchema=True, header=True)

    # Perform data cleaning and transformations
    # Remove rows with any NA values
    df_clean = df.dropna()

    # Add data quality checks
    # Check for missing values in a specific column
    assert df_clean.filter(df_clean["column_name"].isNull()).count() == 0, f"Missing values found in {table}"

    # Check for duplicate rows
    assert df_clean.count() == df_clean.distinct().count(), f"Duplicate rows found in {table}"

    # Check for valid email addresses in the 'email' column (for customers table)
    if table == 'customers':
        email_pattern = re.compile(r"[^@]+@[^@]+\.[^@]+")
        invalid_emails = df_clean.filter(~df_clean['email'].rlike(email_pattern.pattern)).count()
        assert invalid_emails == 0, f"Invalid email addresses found in {table}"

    # Convert to Parquet and write to the target S3 bucket
    target_path = f"s3://{target_bucket}/{table}/"
    df_clean.write.parquet(target_path)

job.commit()
