# PROVIDERS

terraform {
  required_providers {
    godaddy = {
      source = "sigmadigitalza/godaddy-domains"
    }
  }
}


# VARIABLES

variable "fqdn" {
    description = "FQDN of the host to create a CNAME for"
    type = string
}

variable "domain" {
    description = "Top level domain to create the DNS record in"
    type = string
}

# RESOURCES

resource "domains_record" "app" {
  provider = godaddy

  domain = var.domain
  data = var.fqdn
  name = "www"
  type = "CNAME"
}