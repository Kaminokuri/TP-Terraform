resource "google_sql_database_instance" "main" {
  name             = var.db_instance_name
  region           = var.region
  database_version = var.db_version

  deletion_protection = var.db_deletion_protection

  settings {
    tier = var.db_tier

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.self_link
    }
  }

  # Nécessaire pour que le "Private Service Access" soit prêt avant Cloud SQL.
  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.main.name

  depends_on = [google_sql_database_instance.main]
}

resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.main.name
  password = var.db_password

  depends_on = [google_sql_database_instance.main]
}
