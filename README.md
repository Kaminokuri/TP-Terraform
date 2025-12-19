<div align="center">

# Terraform TP — Infra GCP (VPC • Cloud SQL • MIG • Load Balancer)

Infrastructure as Code en Terraform : réseau, base de données privée, compute autoscalé et load balancer HTTP.

<!-- Badges (optionnels) -->
<p>
  <img src="https://img.shields.io/badge/TERRAFORM-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/GOOGLE%20CLOUD-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white" alt="Google Cloud" />
  <img src="https://img.shields.io/badge/IaC-0EA5E9?style=for-the-badge&logo=files&logoColor=white" alt="IaC" />
</p>

<p>
  <img src="https://img.shields.io/badge/CLOUD%20SQL-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white" alt="Cloud SQL" />
  <img src="https://img.shields.io/badge/CLOUD%20STORAGE-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white" alt="Cloud Storage" />
  <img src="https://img.shields.io/badge/LOAD%20BALANCER-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white" alt="Load Balancer" />
  <img src="https://img.shields.io/badge/COMPUTE%20ENGINE-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white" alt="Compute Engine" />
</p>

</div>

---

## Objectif
Ce dépôt contient un projet Terraform structuré (TP) décrivant une infrastructure type sur Google Cloud Platform :

- **VPC + Subnet + Cloud Router + Cloud NAT**
- **Règles firewall** (SSH via IAP recommandé + HTTP pour LB/health checks)
- **Private Service Access** (service networking) pour **Cloud SQL en IP privée**
- **Bucket Cloud Storage**
- **Compute** : template + **Managed Instance Group** + **autoscaling** + **health check**
- **HTTP Load Balancer** externe pointant vers le MIG

> Déploiement réel optionnel : nécessite un projet GCP (facturation + droits IAM).  
> Le code peut aussi être rendu tel quel (structure + configuration + explications).

---

## Structure du projet
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
```

---

## Auteur

* GitHub : Kaminokuri
* OS : macOS
* Projet : TP Terraform (Infrastructure GCP)
