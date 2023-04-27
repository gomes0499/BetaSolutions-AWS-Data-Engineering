output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "A list of IDs for the public subnets"
  value       = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "A list of IDs for the private subnets"
  value       = aws_subnet.private.*.id
}

output "public_security_group_id" {
  description = "The ID of the security group for the public instance"
  value       = aws_security_group.public_instance.id
}

output "private_security_group_id" {
  description = "The ID of the security group for the private instance"
  value       = aws_security_group.private_instance.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.this.id
}
