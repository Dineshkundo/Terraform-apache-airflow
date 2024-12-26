# Terraform GCP VM Setup with Apache Airflow

This Terraform project provisions two virtual machines (VMs) in Google Cloud Platform (GCP):  
1. A general-purpose VM for miscellaneous tasks.  
2. A VM dedicated to running Apache Airflow, with a pre-configured setup.

## Prerequisites

- Ensure you have the following installed:
  - [Terraform](https://www.terraform.io/downloads.html)
  - [Google Cloud CLI](https://cloud.google.com/sdk/docs/install)
- A GCP project with billing enabled.
- The required IAM permissions to create resources in GCP.

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Preview the infrastructure changes:
   ```bash
   terraform plan -var="project_id=<your-gcp-project-id>"
   ```

4. Apply the configuration:
   ```bash
   terraform apply -var="project_id=<your-gcp-project-id>" -auto-approve
   ```

5. Once the setup is complete, note the public IP of the Airflow VM from the Terraform output.

## Accessing Apache Airflow

- Open your browser and navigate to:
  ```
  http://<airflow_vm_public_ip>:8085
  ```
  Replace `<airflow_vm_public_ip>` with the public IP displayed in the Terraform output.

## Cleaning Up

To delete all resources created by Terraform, run:
```bash
terraform destroy -var="project_id=<your-gcp-project-id>" -auto-approve
```

---

### Notes

- The Apache Airflow VM is configured to use port **8085** for the webserver.
- Airflow is set up with a default admin user (`admin`) and password (`admin123`).
- Firewall rules are included to allow HTTP traffic on ports **80** and **8085**.

---
