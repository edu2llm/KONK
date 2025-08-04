## Kafka KRaft Deployment on GCP with Kubernetes (Terraform + Helm)

### 🔧 Requirements
- GCP project with billing enabled
- Terraform CLI
- Google Cloud SDK (for SSH and kubeconfig)
- Helm CLI

### 📦 Project Structure
```
kafka-kraft-on-gcp/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── scripts/
│   ├── install_k8s.sh
│   ├── join_command.sh
│   └── helm_install_kafka.sh
├── helm-values.yaml
└── README.md
```

### 🚀 Steps to Deploy
1. **Edit variables.tf** and set your `project_id`
2. **Run Terraform**
```bash
cd terraform
terraform init
terraform apply -auto-approve
```
3. **SSH into master node** and initialize Kubernetes:
```bash
ssh <master-node-ip>
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube && sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
```
4. **Join workers using the join command** printed from the master.

5. **Install Helm and deploy Kafka in KRaft mode**:
```bash
cd scripts
./helm_install_kafka.sh
```

### ✅ Notes
- Uses Bitnami Kafka Helm chart (no ZooKeeper)
- Designed for ephemeral dev/testing
- You can `terraform destroy` to clean up

### 📬 Output
Kafka broker should be up in `kafka` namespace. Use:
```bash
kubectl get all -n kafka
```
To verify.
