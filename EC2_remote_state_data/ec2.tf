resource "aws_key_pair" "ssh_key" {
  key_name   = "tf-ec2-key"
  public_key = file("../../aws-terraform.pub")
}

resource "aws_instance" "ec2-terraform" {
  ami                         = "ami-04b70fa74e45c3917"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [data.terraform_remote_state.remote_state_vpc.outputs.SGId]
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = data.terraform_remote_state.remote_state_vpc.outputs.subnet_id
  tags = {
    Name = "VM-terraform"
  }
}
