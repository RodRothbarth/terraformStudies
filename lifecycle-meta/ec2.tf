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

  lifecycle {
#    prevent_destroy = true <-this will not allow my ec2 to be destroyed via terraform
    replace_triggered_by = [aws_s3_bucket.bucket_test]
  }

  tags = {
    Name = "VM-terraform"
  }
}
