locals {
  dns_name = var.domain
}

resource "google_dns_managed_zone" "primary" {
  name     = var.zone_name
  dns_name = "${var.domain}."
  project  = var.project
}


resource "google_dns_record_set" "records" {
  for_each = var.records

  name         = "${each.key}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.primary.name
  project      = var.project
  rrdatas      = [each.value]
}
