resource "aws_mwaa_environment" "this" {
  name               = var.airflow_environment_name
  execution_role_arn = var.airflow_role_arn
  source_bucket_arn  = var.airflow_scripts_bucket_arn
  dag_s3_path        = "dags" 
  
    network_configuration {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
}
