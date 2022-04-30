terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("itversitytf-834fa9225831.json")

  project = "itversitytf"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_firewall" "default" {
  name    = "terraform-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8888"]
  }

  source_tags = ["lab"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "deessentials" {
  name         = "deessentials-instance"
  machine_type = "c2-standard-4"
  tags = ["lab"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size = 60
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  metadata = {
    ssh-keys = "dgadiraju:${file("~/.ssh/itvaws.pub")}"
  }

  connection {
    type = "ssh"
    user = "dgadiraju"
    # private_key = "${file("~/.ssh/itvaws")}"
    host = self.network_interface.0.access_config.0.nat_ip
    agent = true
  }

  provisioner "remote-exec" {
    script = "docker-setup.sh"
  }

  provisioner "remote-exec" {
    script = "setup-material.sh"
  }
}

output "gcp_instance_name" {
  value = google_compute_instance.deessentials.name
}

output "gcp_public_ip" {
  value = google_compute_instance.deessentials.network_interface.0.access_config.0.nat_ip
}
