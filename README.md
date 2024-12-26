terraform init
terraform plan -var="project_id=<your-gcp-project-id>"
terraform apply -var="project_id=<your-gcp-project-id>" -auto-approve
http://<airflow_vm_public_ip>:8085
