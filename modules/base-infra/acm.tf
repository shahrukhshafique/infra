locals {
  sub_domains = ["*.${var.domain_name}", var.domain_name]
  tags = {
    DCORE       = "true"
    Environment = var.environment
    Terraform   = "true"
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.2"

  for_each = { for c in local.sub_domains : c => c }

  domain_name       = each.value
  validation_method = "DNS"

  zone_id = module.zones.route53_zone_zone_id[var.domain_name]

  create_route53_records = true
  validate_certificate   = true
  tags                   = local.tags
}
