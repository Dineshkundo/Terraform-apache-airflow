provider "google" {
  project = var.project_id
  region  = var.region
}

# General-purpose VM
resource "google_compute_instance" "general_vm" {
  name         = "general-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20231212" # Ubuntu 22.04 LTS
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {} # Assign public IP
  }

  tags = ["general-http"]

  metadata = {
    startup-script = <<-EOT
      #!/bin/bash
      apt update && apt upgrade -y
      echo "General VM setup completed."
    EOT
  }
}

# Apache Airflow VM
resource "google_compute_instance" "airflow_vm" {
  name         = "airflow-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20231212" # Ubuntu 22.04 LTS
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {} # Assign public IP
  }

  tags = ["airflow-http"]

  metadata = {
    startup-script = <<-EOT
      #!/bin/bash
      set -e
      apt update && apt upgrade -y
      apt install -y python3 python3-pip python3-venv

      # Create virtual environment
      mkdir -p ~/airflow_project
      cd ~/airflow_project
      python3 -m venv airflow_venv
      source airflow_venv/bin/activate

      # Install Apache Airflow
      export AIRFLOW_VERSION=2.6.2
      export PYTHON_VERSION="$(python3 --version | cut -d ' ' -f 2 | cut -d '.' -f 1-2)"
      export CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"

      pip install --upgrade pip
      pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

      # Set up Airflow
      export AIRFLOW_HOME=~/airflow
      airflow db init

      # Start Airflow services
      airflow webserver --port 8085 &
      airflow scheduler &
    EOT
  }
}

# Firewall rule to allow HTTP traffic for both VMs
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "8085"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["general-http", "airflow-http"]
}
