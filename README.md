<!--
✅ README optimisé pour GitHub + IA (structure, mots-clés, étapes, schéma, variables)
👉 Ajoute tes assets dans /assets (ex: assets/demo.gif, assets/banner.svg)
-->

<div align="center">

# 🏗️ Terraform TP — Infra GCP (VPC • Cloud SQL • MIG • Load Balancer)

**Infrastructure as Code** : réseau, base, compute autoscalé et load balancer HTTP — structuré en fichiers Terraform.

<!-- Animation (locale) -->
<p>
  <img src="assets/demo.gif" width="820" alt="Demo Terraform (init/plan/apply)"/>
</p>

<!-- Badges (sans liens externes obligatoires) -->
<p>
  <img alt="Terraform" src="assets/badge-terraform.svg"/>
  <img alt="GCP" src="assets/badge-gcp.svg"/>
  <img alt="IaC" src="assets/badge-iac.svg"/>
</p>

</div>

---

## ✨ Objectif
Ce dépôt contient un projet Terraform organisé (TP) qui décrit une infrastructure type sur Google Cloud Platform :

- **VPC + Subnet + Cloud Router + Cloud NAT**
- **Règles firewall** (SSH via IAP recommandé + HTTP pour LB/health checks)
- **Private Service Access** (service networking) pour **Cloud SQL en IP privée**
- **Bucket GCS**
- **Compute** : template + **Managed Instance Group** + **autoscaling** + **health check**
- **HTTP Load Balancer** externe pointant vers le MIG

> 📌 Note : ce dépôt peut être rendu **sans déploiement GCP** (code + structure + explications).  
> Le déploiement réel nécessite un projet GCP + facturation + droits IAM.

---

## 🧠 TL;DR (pour l’IA / évaluation)
- **Entrées** : `project_id`, `region`, `zones`, `bucket_name`, `db_password`
- **Sorties** : IP du Load Balancer, identifiants/ressources principales
- **Chaînage** : `network` → `private_service_access` → `cloudsql` → `compute(MIG)` → `load_balancer`
- **Sécurité** : `terraform.tfvars` ignoré (secrets), `terraform.tfvars.example` versionné

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
