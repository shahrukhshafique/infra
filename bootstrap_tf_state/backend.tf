provider "aws" {
  region = "us-east-1"
}

module "terraform_state_backend" {
  source = "cloudposse/tfstate-backend/aws"
  namespace  = "webapp-test"
  stage      = "lab"
  name       = "tf"
  attributes = ["state"]
}