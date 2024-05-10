output "subnet_id" {
  value = aws_subnet.subnet.id
}

output "SGId" {
  value = aws_security_group.SG.id
}
