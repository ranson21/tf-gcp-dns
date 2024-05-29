output "nameservers" {
  value = google_dns_managed_zone.primary.name_servers
}

output "zone_id" {
  value = google_dns_managed_zone.primary.managed_zone_id
}

output "name" {
  value = google_dns_managed_zone.primary.name
}

output "id" {
  value = google_dns_managed_zone.primary.id
}

output "dns_name" {
  value = local.dns_name
}


