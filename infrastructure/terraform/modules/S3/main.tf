resource "aws_kms_key" "datalake_s3" {
  description = "KMS key for S3 bucket data lake encryption"
}

resource "aws_s3_bucket" "datalake" {
  bucket               = var.bucket_name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.datalake_s3.arn
      }
    }
  }

  tags = {
    Terraform    = "true"
    Environment  = "datalake"
  }
}

resource "aws_s3_bucket_acl" "datalake" {
  bucket = aws_s3_bucket.datalake.id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "datalake_lifecycle" {
  rule {
    id      = "datalake-rule"
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
  raw_folder = "raw/"
  processed_folder = "processed/"
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