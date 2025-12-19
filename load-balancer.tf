# Load Balancer HTTP externe (global) vers le MIG.
resource "google_compute_global_address" "lb_ip" {
  name = "${var.name_prefix}-lb-ip"

  depends_on = [google_project_service.services]
}

resource "google_compute_backend_service" "backend" {
  name                  = "${var.name_prefix}-backend"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  health_checks         = [google_compute_health_check.http.self_link]
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_instance_group_manager.web.instance_group
  }

  depends_on = [google_project_service.services]
}

resource "google_compute_url_map" "url_map" {
  name            = "${var.name_prefix}-url-map"
  default_service = google_compute_backend_service.backend.self_link

  depends_on = [google_project_service.services]
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.name_prefix}-http-proxy"
  url_map = google_compute_url_map.url_map.self_link

  depends_on = [google_project_service.services]
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name                  = "${var.name_prefix}-fwd-rule"
  ip_address            = google_compute_global_address.lb_ip.address
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_proxy.self_link
  load_balancing_scheme = "EXTERNAL"

  depends_on = [google_project_service.services]
}
