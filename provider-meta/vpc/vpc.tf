resource "aws_vpc" "terraform_vpc_default" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-terraform-provider"
  }
}

resource "aws_vpc" "terraform_vpc_provider1" {
  provider = aws.provider1
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-terraform-provider"
  }
}

resource "aws_vpc" "terraform_vpc_provider2" {
  provider = aws.provider1
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-terraform-provider"
  }
}

