################################################################################
# Sub-Module Usage on Existing/Separate Application EKS Cluster
################################################################################

locals {
  ng = {

    "private-subnet-1a"   = [module.vpc.private_subnets[0]]
    "private-subnet-1b"   = [module.vpc.private_subnets[1]]
    "private-subnet-1c"   = [module.vpc.private_subnets[2]]
    "all-private-subnets" = module.vpc.private_subnets

  }
}

module "eks_managed_node_group" {
  source   = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version  = "19.5.1"
  for_each = var.application-nodegroups

  cluster_name                      = local.cluster_name
  name                              = each.value["name"]
  cluster_version                   = var.eks_cluster_version
  subnet_ids                        = local.ng[each.value["subnet"]]
  cluster_primary_security_group_id = module.applicationeks.cluster_primary_security_group_id
  vpc_security_group_ids = [
    module.applicationeks.cluster_security_group_id, module.nodegroup_sg.security_group_id
  ]

  ami_type = each.value["ami_type"]
  platform = each.value["platform"]

  block_device_mappings = each.value["block_device_mappings"]

  min_size      = each.value["min_size"]
  max_size      = each.value["max_size"]
  desired_size  = each.value["desired_size"]
  update_config = { max_unavailable : 1 }

  instance_types = each.value["instance_type"]
  capacity_type  = each.value["capacity"]

  iam_role_additional_policies = {
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AWSCertificateManagerPrivateCAFullAccess"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AWSCodeArtifactAdminAccess"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  labels = each.value["labels"]
  taints = each.value["taints"]

  tags = local.tags
  # this will get added to what AWS provides
  bootstrap_extra_args = <<-EOT
    # extra args added
    [settings.kernel]
    lockdown = "integrity"

    [settings.kubernetes.node-labels]
    "ClusterName" = ${local.cluster_name}
  EOT

}

