# Active les APIs nécessaires avant de créer les ressources.
resource "google_project_service" "services" {
  for_each           = toset(var.enabled_apis)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
