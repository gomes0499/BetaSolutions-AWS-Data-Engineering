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

variable "ec2_web_server_url" {
  description = "The URL of the EC2 web server backend"
  type        = string
}
