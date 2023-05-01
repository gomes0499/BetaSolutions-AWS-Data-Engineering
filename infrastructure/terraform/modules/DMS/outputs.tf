output "dms_s3_access_role_arn" {
  description = "The ARN of the DMS S3 access IAM role"
  value       = aws_iam_role.dms_s3_access_role.arn
}

output "dms_vpc_management_role_arn" {
  description = "The ARN of the DMS VPC management IAM role"
  value       = aws_iam_role.dms_vpc_management_role.arn
}
