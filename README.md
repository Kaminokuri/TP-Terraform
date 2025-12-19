<div align="center">

# 🏗️ Terraform TP — Infra GCP (VPC • Cloud SQL • MIG • Load Balancer)

Infrastructure as Code en Terraform : réseau, base de données privée, compute autoscalé et load balancer HTTP.

<!-- Badges (optionnels) -->
<p>
  <img src="https://img.shields.io/badge/Terraform-IaC-blue" alt="Terraform badge" />
  <img src="https://img.shields.io/badge/Cloud-GCP-blue" alt="GCP badge" />
  <img src="https://img.shields.io/badge/Status-TP-green" alt="Status badge" />
</p>

</div>

---

## ✨ Objectif
Ce dépôt contient un projet Terraform structuré (TP) décrivant une infrastructure type sur Google Cloud Platform :

- **VPC + Subnet + Cloud Router + Cloud NAT**
- **Règles firewall** (SSH via IAP recommandé + HTTP pour LB/health checks)
- **Private Service Access** (service networking) pour **Cloud SQL en IP privée**
- **Bucket Cloud Storage**
- **Compute** : template + **Managed Instance Group** + **autoscaling** + **health check**
- **HTTP Load Balancer** externe pointant vers le MIG

> 📌 Déploiement réel optionnel : nécessite un projet GCP (facturation + droits IAM).  
> Le code peut aussi être rendu tel quel (structure + configuration + explications).

---

## 📦 Structure du projet
```text
tp-terraform-gcp/
  scripts/
    startup.sh
  apis.tf
  variables.tf
  terraform.tfvars.example
  outputs.tf
  provider.tf
  network.tf
  database.tf
  storage.tf
  compute.tf
  load-balancer.tf
  .gitignore
