provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_instance" "deessentials" {
  instance_id = var.ec2_instance_id
}

resource "null_resource" "stop_instance" {
  provisioner "local-exec" {
    on_failure  = fail
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "\x1B[31m Warning! Stopping instance having id ${var.ec2_instance_id}.................. \x1B[0m"
        aws ec2 stop-instances --instance-ids ${var.ec2_instance_id}
     EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [
    null_resource.stop_spark_lab,
  ]
}

resource "null_resource" "stop_spark_lab" {
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/itvaws")}"
    host = data.aws_instance.deessentials.public_dns
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "cd data-engineering-spark; docker-compose stop cluster_util_db itvdelab",
    ]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
