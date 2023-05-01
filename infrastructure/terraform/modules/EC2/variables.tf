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

variable "public_subnet_id" {
  description = "The subnet ID for the public instance"
  type        = string
}

variable "private_subnet_id" {
  description = "The subnet ID for the private instance"
  type        = string
}

variable "public_security_group_id" {
  description = "The security group ID for the public instance"
  type        = string
}

variable "private_security_group_id" {
  description = "The security group ID for the private instance"
  type        = string
}
