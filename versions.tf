terraform {
#  required_version = ""

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.10"
    }
  }

}

