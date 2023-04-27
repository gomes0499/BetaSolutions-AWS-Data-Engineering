output "airflow_scripts_bucket_arn" {
  description = "The ARN of the S3 bucket containing the Airflow script."
  value       = module.airflow.airflow_scripts_bucket_arn
}


# Outputs for S3 Module
output "bucket_id" {
  value       = module.datalake_s3.bucket_id
  description = "The ID of the created S3 bucket."
}

output "raw_folder_key" {
  value       = module.datalake_s3.raw_folder_key
  description = "The key of the raw folder in the S3 bucket."
}

output "processed_folder_key" {
  value       = module.datalake_s3.processed_folder_key
  description = "The key of the processed folder in the S3 bucket."
}

output "raw_bucket_arn" {
  description = "The ARN of the S3 bucket containing the raw folder."
  value       = module.datalake_s3.bucket_arn
}

output "glue_scripts_bucket_arn" {
  description = "The ARN of the S3 bucket containing the Glue job script."
  value       = module.datalake_s3.glue_scripts_bucket_arn
}

# Output for RDS Module
output "db_instance_endpoint" {
  value       = module.rds.rds_endpoint
  description = "The connection endpoint of the RDS instance."
}

output "db_instance_arn" {
  value       = module.rds.db_instance_arn
  description = "The ARN of the RDS instance."
}

# Output for Redshift Module
output "redshift_cluster_id" {
  description = "The unique identifier for the Redshift cluster."
  value       = module.redshift.redshift_cluster_id
}

output "redshift_endpoint" {
  description = "The connection endpoint for the Redshift cluster."
  value       = module.redshift.redshift_endpoint
}


