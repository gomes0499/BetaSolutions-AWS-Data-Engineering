from awsglue.transforms import *
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql import SparkSession

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

    # Convert to Parquet and write to the target S3 bucket
    target_path = f"s3://{target_bucket}/{table}/"
    df_clean.write.parquet(target_path)

job.commit()