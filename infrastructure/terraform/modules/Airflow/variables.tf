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

variable "airflow_scripts_bucket_arn" {
  description = "The ARN of the S3 bucket containing Airflow scripts"
  type        = string
}
