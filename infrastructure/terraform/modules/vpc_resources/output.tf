output "resources_subnet_ids" {
  description = "The IDs of the subnets created for resources"
  value       = aws_subnet.resources.*.id
}
