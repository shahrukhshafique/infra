
locals {
  vpc-name = "vpc-${var.environment}"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = local.vpc-name
  cidr = var.vpc["cidr"]

  azs             = var.vpc["azs"]
  private_subnets = var.vpc["private_subnets"]
  public_subnets  = var.vpc["public_subnets"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = local.tags
}
