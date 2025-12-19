variable "project_id" {
  description = "ID du projet GCP"
  type        = string
}

variable "region" {
  description = "Région GCP (ex: europe-west1)"
  type        = string
}

variable "zones" {
  description = "Zones utilisées pour le MIG régional (dans la région choisie)"
  type        = list(string)
}

variable "enabled_apis" {
  description = "Liste des APIs à activer"
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com",
    "storage.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}

# Network
variable "network_name" {
  type        = string
  description = "Nom du VPC"
  default     = "tp-vpc"
}

variable "subnet_name" {
  type        = string
  description = "Nom du subnet"
  default     = "tp-subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR du subnet (ex: 10.10.0.0/24)"
  default     = "10.10.0.0/24"
}

variable "ssh_tag" {
  type        = string
  description = "Tag réseau pour SSH via IAP"
  default     = "allow-iap-ssh"
}

variable "http_tag" {
  type        = string
  description = "Tag réseau pour HTTP (health checks / load balancer)"
  default     = "allow-lb-http"
}

# Storage
variable "bucket_name" {
  type        = string
  description = "Nom du bucket (doit être globalement unique)"
}

variable "bucket_location" {
  type        = string
  description = "Localisation du bucket (ex: EU)"
  default     = "EU"
}

# Database (Cloud SQL)
variable "db_instance_name" {
  type        = string
  description = "Nom de l'instance Cloud SQL"
  default     = "tp-sql"
}

variable "db_version" {
  type        = string
  description = "Version DB (ex: MYSQL_8_0, POSTGRES_15)"
  default     = "MYSQL_8_0"
}

variable "db_tier" {
  type        = string
  description = "Tier Cloud SQL (ex: db-f1-micro, db-g1-small...)"
  default     = "db-f1-micro"
}

variable "db_name" {
  type        = string
  description = "Nom de la base"
  default     = "appdb"
}

variable "db_user" {
  type        = string
  description = "Utilisateur DB"
  default     = "appuser"
}

variable "db_password" {
  type        = string
  description = "Mot de passe DB"
  sensitive   = true
}

variable "db_deletion_protection" {
  type        = bool
  description = "Protection contre la suppression (mettre false pour destroy)"
  default     = false
}

# Compute (MIG + Autoscaling)
variable "name_prefix" {
  type        = string
  description = "Préfixe pour nommer les ressources"
  default     = "tp"
}

variable "machine_type" {
  type        = string
  description = "Type de machine Compute Engine"
  default     = "e2-micro"
}

variable "source_image" {
  type        = string
  description = "Image source (famille/projet) pour le disque boot"
  default     = "debian-cloud/debian-12"
}

variable "mig_target_size" {
  type        = number
  description = "Taille initiale du MIG"
  default     = 2
}

variable "min_replicas" {
  type        = number
  description = "Nombre min de VM (autoscaler)"
  default     = 2
}

variable "max_replicas" {
  type        = number
  description = "Nombre max de VM (autoscaler)"
  default     = 5
}

variable "cpu_target" {
  type        = number
  description = "Cible d'utilisation CPU (0-1)"
  default     = 0.6
}
