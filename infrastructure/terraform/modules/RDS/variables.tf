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

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to be used for the resource"
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
