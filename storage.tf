resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  force_destroy               = true

  depends_on = [google_project_service.services]
}
