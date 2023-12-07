resource "aws_instance" "web-app" {
  ami             = data.aws_ami.rhel.id
  instance_type   = var.instance_type["dev"]
  key_name        = var.key_name
  subnet_id       = data.terraform_remote_state.network.outputs.public_subnets[0]
  security_groups = [aws_security_group.ssh.id, aws_security_group.web.id]

  tags = {
    Name = "${local.my_name}-web-app"
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type["dev"]
  subnet_id     = data.terraform_remote_state.network.outputs.private_subnets[0]

  tags = {
    Name = "${local.my_name}-app"
  }
}
