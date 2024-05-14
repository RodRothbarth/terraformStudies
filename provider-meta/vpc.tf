
resource "aws_subnet" "east" {
  vpc_id     = module.vpc.vpc_default
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform-subnet-provider"
  }
}

resource "aws_subnet" "central" {
  provider = aws.central
  vpc_id     = module.vpc.vpc_provider1
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform-subnet-provider"
  }
}

resource "aws_subnet" "west" {
  provider = aws.west
  vpc_id     = module.vpc.vpc_provider2
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform-subnet-provider"
  }
}
