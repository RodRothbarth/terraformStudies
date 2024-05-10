resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "vpc-${var.env_name}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = var.cidr_subnet

  tags = {
    Name = "${var.env_name}-subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "${var.env_name}-internet-gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.env_name}-route-table"
  }
}

resource "aws_route_table_association" "RT_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "SG" {
  name        = "security-group-${var.env_name}"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terraform_vpc.id

  tags = {
    Name = "${var.env_name}-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


