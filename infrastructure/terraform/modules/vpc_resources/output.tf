output "resources_subnet_ids" {
  description = "The IDs of the subnets created for resources"
  value       = aws_subnet.resources.*.id
}

output "internet_gateway_id" {
  description = "The ID of the VPC's internet gateway."
  value       = aws_internet_gateway.resources_igw.id
}

output "resources_sg_id" {
  description = "The security group ID for resources"
  value       = aws_security_group.resources_sg.id
}

