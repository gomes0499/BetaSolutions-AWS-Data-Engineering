output "web_server_public_dns" {
  description = "The public DNS of the web server instance"
  value       = aws_instance.public.public_dns
}

output "web_server_public_ip" {
  description = "The public IP of the web server instance"
  value       = aws_instance.public.public_ip
}
