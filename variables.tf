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

variable "txt_records" {
  type        = map(string)
  description = "Map of TXT records where key is subdomain and value is the TXT record content"
  default     = {}
}

variable "mx_records" {
  description = <<-DESC
    Map of subdomain to its full set of MX records, each entry written as
    "<preference> <host>." exactly as it appears in a zone file.

    MX is a set per name rather than one value per name, which is why this takes
    a list where `records` takes a string: a domain with five mail exchangers is
    one record set with five rrdatas, not five record sets.

    Added because moving a domain's nameservers silently drops every record the
    old provider held, and mail is the one that fails quietly — nothing errors,
    messages simply stop arriving.
  DESC
  type        = map(list(string))
  default     = {}

  # Example:
  # {
  #   "example.com" = ["10 mx1.provider.com.", "20 mx2.provider.com."]
  # }
}
