variable "bucket_name" {
    description = "The name of the S3 bucket to create"
    type = string
}

variable "region" {
    description = "The AWS region where the s3 bucket will be created"
    type = string
}