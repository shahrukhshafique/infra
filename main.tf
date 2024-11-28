#Base-infra module will provision all the required components for DCore
module "base_infra" {
  source                 = "./modules/base-infra"
  
  vpc                    = var.vpc
  eks_cluster_version    = var.eks_cluster_version
  application-nodegroups = var.application-nodegroups
  domain_name            = var.domain_name
  environment            = var.environment
  deployment_region      = var.deployment_region

}
