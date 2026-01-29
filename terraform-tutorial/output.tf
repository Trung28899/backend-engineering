# these outputs will display important information after 'terraform apply'
# if you want to see these without applying, run 'terraform output' command
# this will query the information from the actual instance and display it in terminal
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}