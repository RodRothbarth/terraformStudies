output "vpc_default" {
  value = aws_vpc.terraform_vpc_default.id
}

output "vpc_provider1" {
  value = aws_vpc.terraform_vpc_provider1.id
}

output "vpc_provider2" {
  value = aws_vpc.terraform_vpc_provider2.id
}
