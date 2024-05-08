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

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("../../aws-terraform")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo subnnet_id: ${data.terraform_remote_state.remote_state_vpc.outputs.subnet_id} >> /tmp/network_info.txt",
      "echo SG_id: ${data.terraform_remote_state.remote_state_vpc.outputs.SGId} >> /tmp/network_info.txt"
    ]
  }

  provisioner "file" {
    source      = "./test.txt"
    destination = "/tmp/myapp.txt"
  }

  # Copies the string in content into /tmp/file.log
  provisioner "file" {
    content     = "ami used: ${self.ami}"
    destination = "/tmp/ami.txt"
  }
}
