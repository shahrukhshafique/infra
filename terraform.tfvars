environment       = "webapp-lab"
deployment_region = "us-east-1"

profile_name = "talbots-tf-admin"


vpc = {
  cidr            = "172.31.0.0/16"
  private_subnets = ["172.31.48.0/20", "172.31.64.0/20", "172.31.80.0/20"]
  public_subnets  = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

domain_name = "demo.loadtesting.site"


eks_cluster_version = "1.29"

application-nodegroups = {
  "infra-tools" = {
    name          = "infra-tools"
    ami_type      = "AL2_x86_64"
    platform      = "linux"
    min_size      = 1
    max_size      = 3
    desired_size  = 1
    instance_type = ["t3.small"]
    capacity      = "ON_DEMAND"
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_type = "gp3"
          volume_size = 10
        }
      }
    }
    labels = {
      role        = "infra-tools"
      infra-tools = "true"
    }
    taints = [
      {
        key    = "infra-tools"
        value  = "true"
        effect = "NO_SCHEDULE"
      }
    ]
    subnet = "all-private-subnets"
  },
  "webapp" = {
    name          = "webapp"
    ami_type      = "AL2_x86_64"
    platform      = "linux"
    min_size      = 1
    max_size      = 3
    desired_size  = 1
    instance_type = ["t3.small"]
    capacity      = "SPOT"
    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_type = "gp3"
          volume_size = 10
        }
      }
    }
    labels = {
      role  = "webapp"
      webapp = "true"
    }
    taints = [
      {
        key    = "webapp"
        value  = "true"
        effect = "NO_SCHEDULE"
      }
    ]
    subnet = "all-private-subnets"
  }
}

