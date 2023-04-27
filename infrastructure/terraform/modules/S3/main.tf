resource "aws_kms_key" "datalake_s3" {
  description = "KMS key for S3 bucket data lake encryption"
}

# Data Lake Bucket
resource "aws_s3_bucket" "datalake" {
  bucket = var.bucket_name

  tags = {
    Terraform   = "true"
    Environment = "datalake"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.datalake.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.datalake_s3.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# resource "aws_s3_bucket_acl" "datalake" {
#   bucket = aws_s3_bucket.datalake.id
#   acl    = "private"
# }

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

  bucket = aws_s3_bucket.datalake.id
}

locals {
  raw_folder       = "raw/"
  processed_folder = "processed/"
  dag_folder       = "dags/"
}

resource "aws_s3_object" "raw_folder" {
  bucket       = aws_s3_bucket.datalake.id
  key          = local.raw_folder
  source       = "/dev/null"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "processed_folder" {
  bucket       = aws_s3_bucket.datalake.id
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

resource "aws_s3_bucket_acl" "glue_scripts_acl" {
  bucket = aws_s3_bucket.glue_scripts.id
  acl    = "private"
}

resource "aws_s3_object" "glue_script_file" {
  bucket = aws_s3_bucket.glue_scripts.id
  key    = "spark-job.py"
  source = "../../../../scripts/spark-job.py"
}

# Airflow Bucket
resource "aws_s3_bucket" "airflow_scripts" {
  bucket = "wu9airflow-scripts"

  tags = {
    Terraform   = "true"
    Environment = "airflow"
  }
}

resource "aws_s3_bucket_acl" "airflow_scripts_acl" {
  bucket = aws_s3_bucket.airflow_scripts.id
  acl    = "private"
}

resource "aws_s3_object" "airflow_script_file" {
  bucket = aws_s3_bucket.airflow_scripts.id
  key    = "dag.py"
  source = "../../../../scripts/dag.py"
}

resource "aws_s3_object" "airflow_script_folder" {
  bucket       = aws_s3_bucket.airflow_scripts.id
  key          = local.dag_folder
  source       = "/dev/null"
  content_type = "application/x-directory"
}
