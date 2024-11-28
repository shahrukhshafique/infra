

provider "aws" {
  region  = var.deployment_region
  profile = var.profile_name
}


provider "kubernetes" {
  host                   = module.base_infra.cluster_endpoint
  cluster_ca_certificate = base64decode(module.base_infra.cluster_certificate_authority_data)



  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.base_infra.cluster_name, "--region", var.deployment_region, "--profile", var.profile_name]
  }
}


