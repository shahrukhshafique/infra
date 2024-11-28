##################################################################
# EKS Module for Application Cluster Setup
##################################################################

locals {
  cluster_name                   = "${var.environment}-eks"
  resolve_conflicts_preserve     = "PRESERVE"
  resolve_conflicts_on_overwrite = "OVERWRITE"


}
module "applicationeks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name                   = local.cluster_name
  cluster_version                = var.eks_cluster_version
  cluster_endpoint_public_access = true
  cluster_addons = {
    coredns = {
      preserve                    = true
      most_recent                 = true
      resolve_conflicts_on_create = local.resolve_conflicts_preserve # Use resolve_conflicts_on_create for initial creation
      resolve_conflicts_on_update = local.resolve_conflicts_on_overwrite
      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
    kube-proxy = {
      most_recent                 = true
      resolve_conflicts_on_create = local.resolve_conflicts_preserve # Use resolve_conflicts_on_create for initial creation
      resolve_conflicts_on_update = local.resolve_conflicts_on_overwrite
    }
    vpc-cni = {
      most_recent                 = true
      resolve_conflicts_on_create = local.resolve_conflicts_preserve # Use resolve_conflicts_on_create for initial creation
      resolve_conflicts_on_update = local.resolve_conflicts_on_overwrite
    }
    aws-ebs-csi-driver = {
      most_recent                 = true
      resolve_conflicts_on_create = local.resolve_conflicts_preserve # Use resolve_conflicts_on_create for initial creation
      resolve_conflicts_on_update = local.resolve_conflicts_on_overwrite
    }
  }

  # disabling logs
  cluster_enabled_log_types   = []
  create_cloudwatch_log_group = false
  create_kms_key              = false
  enable_irsa                 = false


  cluster_encryption_config = {}

  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.private_subnets
  create_aws_auth_configmap = true

  tags = local.tags
}
