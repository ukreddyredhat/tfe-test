terraform {
  required_version = ">= 1.2"
}

#variable "gcp_credentials" {
#  description = "GCP credential needed by google provider"
#  default     = " "
#}

variable "gcp_project" {
  description = "GCP project name"
  default     = "fiery-melody-367206"
}

variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default     = "europe-west3"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. us-east1-a"
  default     = "europe-west3-a"
}

variable "machine_type" {
  description = "GCP machine type"
  default     = "e2-micro"
}

variable "instance_name" {
  description = "GCP instance name"
  default     = "demo-1"
}

variable "image" {
  description = "image to build instance from"
  default     = "debian-cloud/debian-11"
}

provider "google" {
  #credentials = var.gcp_credentials
  project  = var.gcp_project
  region   = var.gcp_region
}

resource "google_compute_instance" "demo" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

}

output "external_ip" {
  value = google_compute_instance.demo.network_interface.0.access_config.0.nat_ip
}
