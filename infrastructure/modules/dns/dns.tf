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

# resource "godaddy_domain_record" "app" {
#   domain   = "${var.domain}"

#   record {
#     name = "www"
#     type = "CNAME"
#     data = "${var.fqdn}"
#     ttl = 3600
#   }

  // specify any custom nameservers for your domain
  // note: godaddy now requires that the 'custom' nameservers are first supplied through the ui
  // nameservers = ["ns7.domains.com", "ns6.domains.com"]
# }