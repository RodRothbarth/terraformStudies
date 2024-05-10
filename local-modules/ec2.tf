resource "aws_key_pair" "ssh_key" {
  key_name   = "tf-ec2-key-${var.env}"
  public_key = file("../../aws-terraform.pub")
}

resource "aws_instance" "ec2-terraform" {
  ami                         = "ami-04b70fa74e45c3917"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.network.SGId]
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = module.network.subnet_id
  tags = {
    Name = "VM-${var.env}"
  }
}

#TODO só é possivel acessar os paremtros que estão no module a partir do output. module.network."subnet_id"
