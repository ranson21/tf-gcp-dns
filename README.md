# ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) GCP Cloud DNS

This Terraform module manages a Google Cloud DNS zone and its associated A records.

## Features

- Creates a managed DNS zone in Google Cloud
- Dynamically creates A records using a map of domains and IP addresses
- Supports custom TTL settings for DNS records
- Provides useful outputs for zone management and nameserver configuration

## Usage

```hcl
module "dns" {
  source = "./tf-gcp-dns"

  zone_name = "public-dns"
  domain    = "example.com"
  project   = "my-gcp-project"
  
  records = {
    "example.com"     = "203.0.113.10"
    "www.example.com" = "203.0.113.11"
  }
}
```

## Terragrunt Example

```hcl
terraform {
  source = "${include.parent.locals.source}/tf-gcp-dns"
}

inputs = {
  zone_name = "public-dns"
  domain    = include.parent.locals.domain
  project   = dependency.project.outputs.project

  records = {
    "${include.parent.locals.domain}" = dependency.load-balancer.outputs.external_ip
  }
}
```

## Requirements

- Terraform >= 0.13
- Google Provider >= 4.0
- Google Cloud project with the Cloud DNS API enabled
- Appropriate IAM permissions to create DNS zones and records

## Input Variables

| Name      | Description                                             | Type        | Required |
| --------- | ------------------------------------------------------- | ----------- | -------- |
| zone_name | The name to use for the DNS zone                        | string      | yes      |
| domain    | The domain name for the DNS zone (without trailing dot) | string      | yes      |
| project   | The GCP project ID where the DNS zone will be created   | string      | yes      |
| records   | Map of domain names to IP addresses for A records       | map(string) | yes      |

## Outputs

| Name         | Description                                                         |
| ------------ | ------------------------------------------------------------------- |
| zone_id      | The ID of the created DNS zone                                      |
| zone_name    | The name of the created DNS zone                                    |
| name_servers | The list of nameservers that should be used to configure the domain |
| dns_records  | Map of created DNS A records and their IPs                          |
| domain       | The domain name of the DNS zone (with trailing dot)                 |

## DNS Configuration

After applying this module, you'll need to configure your domain registrar to use the Google nameservers provided in the `name_servers` output.

## Contributing

Please feel free to submit issues, fork the repository and create pull requests for any improvements.

## License

[MIT](./LICENSE)
