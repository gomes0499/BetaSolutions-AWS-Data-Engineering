# Data Lake Bucket
resource "aws_s3_bucket" "datalake" {
  bucket = var.bucket_name

  tags = {
    Terraform   = "true"
    Environment = "datalake"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "datalake_lifecycle" {
  rule {
    id     = "datalake-rule"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }

  bucket = aws_s3_bucket.datalake.bucket
}

locals {
  raw_folder       = "raw/"
  processed_folder = "processed/"
  dag_folder       = "dags/"
}

resource "aws_s3_object" "raw_folder" {
  bucket       = aws_s3_bucket.datalake.bucket
  key          = local.raw_folder
  source       = "/dev/null"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "processed_folder" {
  bucket       = aws_s3_bucket.datalake.bucket
  key          = local.processed_folder
  source       = "/dev/null"
  content_type = "application/x-directory"
}

# Glue Bucket
resource "aws_s3_bucket" "glue_scripts" {
  bucket = "wu9glue-scripts"

  tags = {
    Terraform   = "true"
    Environment = "spark"
  }
}

resource "aws_s3_object" "glue_script_file" {
  bucket = aws_s3_bucket.glue_scripts.bucket
  key    = "spark/spark-job.py"
  source = "../../scripts/spark-job.py"
}

# Airflow Bucket
resource "aws_s3_bucket" "airflow_scripts" {
  bucket = "wu9airflow-scripts"

  tags = {
    Terraform   = "true"
    Environment = "airflow"
  }
}

resource "aws_s3_object" "airflow_script_file" {
  bucket = aws_s3_bucket.airflow_scripts.bucket
  key    = "dag.py"
  source = "../../scripts/dag.py"
}

resource "aws_s3_object" "airflow_script_folder" {
  bucket       = aws_s3_bucket.airflow_scripts.bucket
  key          = local.dag_folder
  source       = "/dev/null"
  content_type = "application/x-directory"
}
