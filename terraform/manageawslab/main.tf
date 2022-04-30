provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = "ssh port for remote login"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = "jupyter port to access itversity material"
      from_port        = var.jupyterlab_port
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = var.jupyterlab_port
    }
  ]
}

resource "aws_instance" "deessentials" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = "itvaws"
  vpc_security_group_ids = [aws_security_group.main.id]

  root_block_device {
    volume_size = 60
    volume_type = "gp3"
  }

  tags = {
    Name = "itversity"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/itvaws")}"
    host = self.public_dns
    agent = true
  }

  provisioner "remote-exec" {
    script = "docker-setup.sh"
  }

  provisioner "remote-exec" {
    script = "setup-material.sh"
  }
}

output "ec2_instance_id" {
  value = aws_instance.deessentials.id
}

output "ec2_public_dns" {
  value = aws_instance.deessentials.public_dns
}
