terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.58.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}


resource "google_compute_instance" "terraform" {
  project      = var.project_id
  name         = var.instance_name
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
}

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = "US"
  storage_class = var.storage_class
  force_destroy = true

  public_access_prevention = "enforced" 

}

resource "google_bigquery_dataset" "default" {
  dataset_id                  = var.dataset_id
  friendly_name               = "test-terraform"
  description                 = "This is a test description"
  location                    = "US"
}