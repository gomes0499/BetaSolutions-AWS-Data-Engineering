output "sns_topic_arn" {
  description = "The ARN of the SNS Topic for Glue Job status change notifications"
  value       = aws_sns_topic.glue_job_status_change.arn
}
