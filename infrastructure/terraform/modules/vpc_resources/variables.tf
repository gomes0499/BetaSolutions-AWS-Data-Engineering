variable "resources_vpc_name" {
  description = "The name of the resources VPC"
  type        = string
}

variable "resources_vpc_cidr" {
  description = "The CIDR block for the resources VPC"
  type        = string
}

variable "resources_subnet_cidrs" {
  description = "The CIDR blocks for the resources subnets"
  type        = list(string)
}

variable "resources_subnet_azs" {
  description = "A list of Availability Zones for the resources subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"] 
}
