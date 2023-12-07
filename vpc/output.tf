output "VPC-id" {
  value = aws_vpc.dev.id
}

output "eip" {
  value = aws_eip.dev_eip.public_ip
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}