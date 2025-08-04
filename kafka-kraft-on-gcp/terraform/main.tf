provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "k8s_node" {
  count        = 3
  name         = "k8s-node-${count.index}"
  machine_type = "e2-standard-2"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata_startup_script = file("../scripts/install_k8s.sh")
  tags = ["k8s"]
}

output "node_ips" {
  value = google_compute_instance.k8s_node[*].network_interface[0].access_config[0].nat_ip
}
