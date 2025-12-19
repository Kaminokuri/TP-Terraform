output "load_balancer_ip" {
  description = "IP publique du load balancer HTTP"
  value       = google_compute_global_address.lb_ip.address
}

output "bucket_name" {
  value = google_storage_bucket.bucket.name
}

output "sql_connection_name" {
  value = google_sql_database_instance.main.connection_name
}

output "network" {
  value = google_compute_network.vpc.name
}

output "subnet" {
  value = google_compute_subnetwork.subnet.name
}
