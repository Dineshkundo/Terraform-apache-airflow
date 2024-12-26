# Ansible Apache Airflow Setup

## Steps to Use:

### 1. Create Inventory File
Create an inventory file `inventory.ini` with your GCP instance details:

```
[gcp]
<your-instance-ip> ansible_user=<your-user> ansible_ssh_private_key_file=<path-to-private-key>
```

### 2. Run the Playbook
Execute the playbook:

```
ansible-playbook -i inventory.ini setup_airflow.yml
```

### 3. Access Airflow Web Interface
After the playbook finishes, access the Airflow UI:

```
http://<your-instance-ip>:8085
```

- **Username:** admin  
- **Password:** admin123

---

