provider "google" {
  credentials = file("../itversitytf-834fa9225831.json")

  project = "itversitytf"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "null_resource" "start_instance" {
  provisioner "local-exec" {
    on_failure  = fail
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "Starting instance having id ${var.gcp_instance_name}"
        export CLOUDSDK_PYTHON=python3.7
        gcloud compute instances start --project ${var.gcp_project_name} --zone ${var.gcp_zone_name} ${var.gcp_instance_name}
     EOT
  }

  # this setting will trigger script every time, change it something needed
  triggers = {
    always_run = "${timestamp()}"
  }
}

data "google_compute_instance" "deessentials" {
  name = var.gcp_instance_name

  depends_on = [
    null_resource.start_instance,
  ]
}

resource "null_resource" "start_spark_lab" {

  connection {
    type = "ssh"
    user = "dgadiraju"
    host = data.google_compute_instance.deessentials.network_interface.0.access_config.0.nat_ip
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
}

output "gcp_public_ip" {
  value = data.google_compute_instance.deessentials.network_interface.0.access_config.0.nat_ip
}
