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

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the RDS instance."
  type        = list(string)
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to be used for the resource"
}
