resource "aws_s3_bucket" "datalake" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Terraform = "true"
    Environment = "datalake"
  }
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

resource "aws_s3_bucket_object" "raw_folder" {
  bucket       = aws_s3_bucket.datalake.id
  key          = local.raw_folder
  source       = "/dev/null"
  content_type = "application/x-directory"
}

resource "aws_s3_bucket_object" "processed_folder" {
  bucket       = aws_s3_bucket.datalake.id
  key          = local.processed_folder
  source       = "/dev/null"
  content_type = "application/x-directory"
}
