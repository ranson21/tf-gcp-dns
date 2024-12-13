variable "zone_name" {
  description = "The name to use for the DNS zone"
  type        = string
}

variable "domain" {
  description = "The domain name for the DNS zone (without trailing dot)"
  type        = string
}

variable "project" {
  description = "The GCP project ID where the DNS zone will be created"
  type        = string
}

variable "records" {
  description = "Map of domain names to IP addresses for A records"
  type        = map(string)

  # Example:
  # {
  #   "example.com" = "203.0.113.10"
  #   "sub.example.com" = "203.0.113.11"
  # }
}
