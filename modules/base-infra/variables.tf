variable "environment" {
  description = "Sepcify the application environment"
  type        = string
}

variable "deployment_region" {
  description = "Sepcify the deployment region"
  type        = string
}


variable "domain_name" {
  description = "Domain name to be used"
  type        = string

}
variable "vpc" {
  description = "value"
  type = object({
    cidr            = string
    private_subnets = list(string)
    public_subnets  = list(string)
    azs             = list(string)
  })
}



variable "eks_cluster_version" {
  description = "Application Cluster details"
  type        = string
  default     = "1.29"
}

variable "application-nodegroups" {
  description = "Node Groups sepcifiations for the Applicaion Cluster"
  type = map(object({
    name                  = string
    ami_type              = string
    platform              = string
    min_size              = number
    max_size              = number
    desired_size          = number
    instance_type         = list(string)
    capacity              = string
    block_device_mappings = object({})
    labels                = map(string)
    subnet                = string
    taints                = any
  }))
}


