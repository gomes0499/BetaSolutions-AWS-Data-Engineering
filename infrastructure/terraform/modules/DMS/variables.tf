variable "replication_instance_identifier" {
  description = "A unique identifier for the DMS replication instance."
  type        = string
}

variable "replication_instance_class" {
  description = "The compute and memory capacity of the DMS replication instance."
  type        = string
}

variable "allocated_storage_dms" {
  description = "The amount of storage to be allocated for the replication instance."
  type        = number
}

variable "subnet_group_name_dms" {
  description = "The name of the existing DMS subnet group."
  type        = string
}

variable "rds_endpoint" {
  description = "The endpoint for the RDS instance."
  type        = string
}

variable "rds_username" {
  description = "The username for the RDS instance."
  type        = string
}

variable "rds_password" {
  description = "The password for the RDS instance."
  type        = string
}

variable "s3_destination_bucket_arn" {
  description = "The Amazon Resource Name (ARN) of the destination S3 bucket."
  type        = string
}


variable "service_access_role_arn" {
  description = "The Amazon Resource Name (ARN) of the destination S3 bucket."
  type        = string
}
