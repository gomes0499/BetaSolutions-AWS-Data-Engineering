output "airflow_environment_arn" {
  description = "The Amazon Resource Name (ARN) of the created Amazon MWAA environment."
  value       = aws_mwaa_environment.this.arn
}

output "airflow_environment_name" {
  description = "The name of the created Amazon MWAA environment."
  value       = aws_mwaa_environment.this.name
}

output "airflow_scripts_bucket_arn" {
  description = "The ARN of the S3 bucket containing Airflow scripts"
  value       = var.airflow_scripts_bucket_arn
}
