# Variables for S3 Module
variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}

variable "region" {
  description = "The AWS region where the s3 bucket will be created"
  type        = string
}

# Variables for RDS
variable "db_instance_identifier" {
  description = "The name of the RDS instance."
  type        = string
}

variable "db_engine" {
  description = "The database engine to use."
  type        = string
}

variable "db_username" {
  description = "The master username for the database instance."
  type        = string
}

variable "db_password" {
  description = "The master password for the database instance."
  type        = string
}

variable "db_instance_class" {
  description = "The instance class of the RDS instance."
  type        = string
}

variable "subnet_group_name" {
  description = "The name of the existing RDS subnet group."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the RDS instance."
  type        = list(string)
}

variable "allocated_storage" {
  description = "The amount of allocated storage for the RDS instance, in gigabytes."
  type        = number
}

variable "engine_version" {
  description = "The version of the database engine."
  type        = string
}

variable "multi_az" {
  description = "If true, the RDS instance will be created in multiple availability zones."
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "Specifies whether the underlying storage should be encrypted."
  type        = bool
  default     = true
}

# Variables for the redshift 
variable "cluster_identifier" {
  description = "A unique identifier for the Redshift cluster."
  type        = string
}

variable "node_type" {
  description = "The node type to be provisioned for the Redshift cluster."
  type        = string
}

variable "number_of_nodes" {
  description = "The number of compute nodes in the Redshift cluster."
  type        = number
}

variable "master_username" {
  description = "The master username for the Redshift cluster."
  type        = string
}

variable "master_password" {
  description = "The master password for the Redshift cluster."
  type        = string
}

# Variables for DMS Module
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

variable "rds_username" {
  description = "The username for the RDS instance."
  type        = string
}

variable "rds_password" {
  description = "The password for the RDS instance."
  type        = string
}

variable "service_access_role_arn" {
  description = "The Amazon Resource Name (ARN) of the destination S3 bucket."
  type        = string
}