################################################################################
# Network Configs
################################################################################
output "vpc_id" {
  description = "The IDs of the VPCs"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnets
}


output "private_subnets" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "acm_certificate_module" {
  description = "Complete details of ACM module"
  value       = module.acm
}


output "zones_namespace_servers" {
  description = "Complete details of ACM module"
  value       = module.zones.route53_zone_name_servers
}


################################################################################
# EKS Cluster
################################################################################

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.applicationeks.cluster_arn
}
output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.applicationeks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.applicationeks.cluster_endpoint
}

output "cluster_id" {
  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
  value       = module.applicationeks.cluster_id
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.applicationeks.cluster_name
}

output "cluster_platform_version" {
  description = "Platform version for the cluster"
  value       = module.applicationeks.cluster_platform_version
}

output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = module.applicationeks.cluster_status
}

output "cluster_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
  value       = module.applicationeks.cluster_security_group_id
}


################################################################################
# EKS Managed Node Group
################################################################################

output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.applicationeks.eks_managed_node_groups
}

output "eks_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by EKS managed node groups"
  value       = module.applicationeks.eks_managed_node_groups_autoscaling_group_names
}

################################################################################
# Additional
################################################################################

output "aws_auth_configmap_yaml" {
  description = "Formatted yaml output for base aws-auth configmap containing roles used in cluster node groups/fargate profiles"
  value       = module.applicationeks.aws_auth_configmap_yaml
}



