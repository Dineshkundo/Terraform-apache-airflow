output "general_vm_public_ip" {
  description = "Public IP of the general-purpose VM"
  value       = google_compute_instance.general_vm.network_interface[0].access_config[0].nat_ip
}

output "airflow_vm_public_ip" {
  description = "Public IP of the Apache Airflow VM"
  value       = google_compute_instance.airflow_vm.network_interface[0].access_config[0].nat_ip
}
