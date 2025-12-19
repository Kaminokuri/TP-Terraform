data "google_compute_default_service_account" "default" {
  project    = var.project_id
  depends_on = [google_project_service.services]
}

resource "google_compute_instance_template" "web" {
  name_prefix  = "${var.name_prefix}-tmpl-"
  machine_type = var.machine_type

  tags = [var.http_tag, var.ssh_tag]

  disk {
    boot         = true
    auto_delete  = true
    source_image = var.source_image
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
    # Pas de access_config => pas d'IP publique (accès SSH via IAP + sortie internet via NAT)
  }

  metadata_startup_script = file("${path.module}/scripts/startup.sh")

  service_account {
    email  = data.google_compute_default_service_account.default.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  depends_on = [google_project_service.services]
}

resource "google_compute_health_check" "http" {
  name = "${var.name_prefix}-hc"

  http_health_check {
    port         = 80
    request_path = "/"
  }

  depends_on = [google_project_service.services]
}

resource "google_compute_region_instance_group_manager" "web" {
  name               = "${var.name_prefix}-mig"
  region             = var.region
  base_instance_name = "${var.name_prefix}-vm"
  target_size        = var.mig_target_size

  distribution_policy_zones = var.zones

  version {
    instance_template = google_compute_instance_template.web.self_link
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http.self_link
    initial_delay_sec = 60
  }

  depends_on = [google_project_service.services]
}

resource "google_compute_region_autoscaler" "web" {
  name   = "${var.name_prefix}-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.web.self_link

  autoscaling_policy {
    min_replicas    = var.min_replicas
    max_replicas    = var.max_replicas
    cooldown_period = 60

    cpu_utilization {
      target = var.cpu_target
    }
  }

  depends_on = [google_project_service.services]
}
