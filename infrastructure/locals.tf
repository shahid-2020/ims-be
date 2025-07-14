locals {
  domain                      = "codlr.store"
  subdomain                   = "api"
  fully_qualified_domain_name = "${terraform.workspace == "production" ? "" : "${terraform.workspace}."}${local.subdomain}.${local.domain}"
}
