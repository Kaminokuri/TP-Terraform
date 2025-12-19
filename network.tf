resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false

  depends_on = [google_project_service.services]
}

resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnet_name
  region                   = var.region
  ip_cidr_range            = var.subnet_cidr
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true

  depends_on = [google_project_service.services]
}

resource "google_compute_router" "router" {
  name    = "${var.name_prefix}-router"
  region  = var.region
  network = google_compute_network.vpc.id

  depends_on = [google_project_service.services]
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.name_prefix}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  depends_on = [google_project_service.services]
}

# Firewall SSH via IAP (pour des VM sans IP publique).
# Source range officiel IAP TCP: 35.235.240.0/20
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.name_prefix}-allow-iap-ssh"
  network = google_compute_network.vpc.name

  direction     = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
  target_tags   = [var.ssh_tag]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  depends_on = [google_project_service.services]
}

# Firewall HTTP pour les backends du Load Balancer (health checks / proxy).
# Ranges officiels des health checks: 35.191.0.0/16, 130.211.0.0/22
resource "google_compute_firewall" "allow_lb_http" {
  name    = "${var.name_prefix}-allow-lb-http"
  network = google_compute_network.vpc.name

  direction     = "INGRESS"
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
  target_tags   = [var.http_tag]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  depends_on = [google_project_service.services]
}

# Global private address + Service Networking connection (Private Service Access),
# requis pour Cloud SQL en IP privée.
resource "google_compute_global_address" "private_service_range" {
  name          = "${var.name_prefix}-psa-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link

  depends_on = [google_project_service.services]
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_service_range.name]

  depends_on = [google_project_service.services]
}
