provider "google" {
  credentials = file("../itversitytf-834fa9225831.json")

  project = "itversitytf"
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "google_compute_instance" "deessentials" {
  name = var.gcp_instance_name
}

resource "null_resource" "stop_instance" {
  provisioner "local-exec" {
    on_failure  = fail
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "\x1B[31m Warning! Stopping instance having id ${var.gcp_instance_name}.................. \x1B[0m"
        export CLOUDSDK_PYTHON=python3.7
        gcloud compute instances stop --project ${var.gcp_project_name} --zone ${var.gcp_zone_name} ${var.gcp_instance_name}
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
    user = "dgadiraju"
    host = data.google_compute_instance.deessentials.network_interface.0.access_config.0.nat_ip
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
