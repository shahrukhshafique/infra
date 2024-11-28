
terraform {
  backend "s3" {
    bucket         = "webapp-test-lab-tf-state"
    key            = "state/lab-useast1.tfstate"
    region         = "us-east-1"
    dynamodb_table = "webapp-test-lab-tf-state-lock"
    encrypt        = true
    profile        = var.profile
  }
}