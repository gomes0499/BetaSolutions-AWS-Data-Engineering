output "rds_endpoint" {
  description = "The connection endpoint of the RDS instance."
  value       = aws_db_instance.default.endpoint
}

output "db_instance_arn" {
  value       = aws_db_instance.default.arn
  description = "The ARN of the RDS instance."
}

output "database_name" {
  description = "The name of the database in the RDS instance"
  value       = aws_db_instance.default.db_name
}