module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0"
  zones = {
    (var.domain_name) = {
      comment = "Route53 zone"
      tags    = local.tags
    },
  }
}

module "public_records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.11.1"

  zone_id = module.zones.route53_zone_zone_id[var.domain_name]

  records = [
    {
      name = "*"
      type = "CNAME"
      ttl  = 3600
      records = [
        module.alb.lb_dns_name
      ]
    }
  ]
  depends_on = [module.zones]
}
