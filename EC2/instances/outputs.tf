output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.web-app.public_ip
}
