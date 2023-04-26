output "rds_endpoint" {
  description = "The connection endpoint of the RDS instance."
  value       = aws_db_instance.default.endpoint
}

output "db_instance_arn" {
  value       = aws_db_instance.default.arn
  description = "The ARN of the RDS instance."
}
