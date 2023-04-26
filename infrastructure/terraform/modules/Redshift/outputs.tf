output "redshift_cluster_id" {
  description = "The unique identifier for the Redshift cluster."
  value       = aws_redshift_cluster.default.id
}

output "redshift_endpoint" {
  description = "The connection endpoint for the Redshift cluster."
  value       = aws_redshift_cluster.default.endpoint
}
