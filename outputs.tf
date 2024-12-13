output "zone_id" {
  description = "The ID of the created DNS zone"
  value       = google_dns_managed_zone.primary.id
}

output "zone_name" {
  description = "The name of the created DNS zone"
  value       = google_dns_managed_zone.primary.name
}

output "name_servers" {
  description = "The list of nameservers that should be used to configure the domain"
  value       = google_dns_managed_zone.primary.name_servers
}

output "dns_records" {
  description = "Map of created DNS A records and their IPs"
  value = {
    for record in google_dns_record_set.records :
    trimsuffix(record.name, ".") => record.rrdatas[0]
  }
}

output "domain" {
  description = "The domain name of the DNS zone (with trailing dot)"
  value       = google_dns_managed_zone.primary.dns_name
}
