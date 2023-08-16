provider "google" {
  project = "fiery-melody-367206"
  region  = "us-central1"
}

resource "google_container_cluster" "my_cluster" {
  name               = "my-cluster"
  location           = "us-central1"
  initial_node_count = 1

  node_config {
    machine_type = "n1-standard-2"
  }
}
