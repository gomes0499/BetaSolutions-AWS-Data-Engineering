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

# Variables for Glue
variable "glue_job_name" {
  description = "The name of the Glue job."
  type        = string
}

variable "glue_service_role_arn" {
  description = "The ARN of the IAM role with the necessary permissions for the Glue job."
  type        = string
}

variable "glue_script_name" {
  description = "The name of the Glue job script file."
  type        = string
}

# Variables for Airflow
variable "airflow_environment_name" {
  description = "The name of the Amazon MWAA environment."
  type        = string
}

variable "airflow_role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role used by the Amazon MWAA environment."
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to be assigned to the Amazon MWAA environment."
  type        = list(string)
}

variable "subnet_ids" {
  description = "A list of subnet IDs to be assigned to the Amazon MWAA environment."
  type        = list(string)
}

# Variables for CloudWatch
variable "glue_job_states" {
  description = "A list of Glue Job states to monitor"
  type        = list(string)
  default     = ["SUCCEEDED", "FAILED", "STOPPED", "TIMEOUT"]
}

# Variables for VPC
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

# Variables for EC2
variable "public_instance_ami" {
  description = "The AMI ID for the public instance"
  type        = string
}

variable "public_instance_type" {
  description = "The instance type for the public instance"
  type        = string
}

variable "private_instance_ami" {
  description = "The AMI ID for the private instance"
  type        = string
}

variable "private_instance_type" {
  description = "The instance type for the private instance"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair for the instances"
  type        = string
}

# Variables for ApiGateway
variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_description" {
  description = "The description of the API Gateway"
  type        = string
}

variable "integration_description" {
  description = "The description of the API Gateway integration"
  type        = string
}

# Variables for Cognito
variable "user_pool_name" {
  description = "The name for the Cognito User Pool"
  type        = string
}

variable "user_pool_client_name" {
  description = "The name for the Cognito User Pool Client"
  type        = string
}

variable "user_pool_domain" {
  description = "The domain name for the Cognito User Pool"
  type        = string
}

# Variables for VPC-Resources
variable "resources_vpc_name" {
  description = "The name of the resources VPC"
}

variable "resources_vpc_cidr" {
  description = "The CIDR block for the resources VPC"
}

variable "resources_subnet_cidrs" {
  description = "The CIDR blocks for the resources subnets"
  type        = list(string)
}
