variable "machine_type" {
  description = "Type of machine to use"
  default     = "e2-medium"
}

variable "disk_size" {
  description = "Disk size in GB"
  default     = 10
}

variable "service_account" {
  description = "Service account to attach to the instance"
  default     = ""
}

resource "google_compute_instance" "instance" {
  name         = "terraform-instance"
  machine_type = var.machine_type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20220608"
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    email  = var.service_account
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}