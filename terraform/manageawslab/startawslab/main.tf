provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "null_resource" "start_instance" {
  provisioner "local-exec" {
    on_failure  = fail
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "Starting instance having id ${var.ec2_instance_id}"
        aws ec2 start-instances --instance-ids ${var.ec2_instance_id}
     EOT
  }

  # this setting will trigger script every time, change it something needed
  triggers = {
    always_run = "${timestamp()}"
  }
}

data "aws_instance" "deessentials" {
  instance_id = var.ec2_instance_id

  depends_on = [
    null_resource.start_instance,
  ]
}

resource "null_resource" "start_spark_lab" {

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/itvaws")}"
    host = data.aws_instance.deessentials.public_dns
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "cd data-engineering-spark; docker-compose start cluster_util_db itvdelab",
    ]
  }

  # this setting will trigger script every time, change it something needed
  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [
    null_resource.start_instance,
  ]
}

output "ec2_public_dns" {
  value = data.aws_instance.deessentials.public_dns
}
