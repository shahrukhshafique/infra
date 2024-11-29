# AWS EKS Terraform Infrastructure with GitHub Actions

This repository contains Terraform code to provision AWS infrastructure for Amazon Elastic Kubernetes Service (EKS). Additionally, GitHub Actions workflows are included to automate the process of applying and destroying the Terraform configurations.

## Table of Contents

- [Overview](#overview)
- [Pre-requisites](#pre-requisites)
- [Getting Started](#getting-started)
  - [Clone the repository](#clone-the-repository)
  - [Setup AWS Credentials](#setup-aws-credentials)
  - [Terraform Configuration](#terraform-configuration)
- [GitHub Actions Workflows](#github-actions-workflows)
  - [Apply Workflow](#apply-workflow)
  - [Destroy Workflow](#destroy-workflow)
- [Usage](#usage)
  - [Applying the Terraform Configuration](#applying-the-terraform-configuration)
  - [Destroying the Infrastructure](#destroying-the-infrastructure)

## Overview

This repository provides Terraform scripts that deploy an AWS Elastic Kubernetes Service (EKS) cluster along with the necessary AWS infrastructure resources like VPC, subnets, security groups and few other resources. It also includes GitHub Actions workflows for automating the `terraform apply` and `terraform destroy` commands to easily provision and tear down the infrastructure.

## Pre-requisites

Before you begin, make sure you have the following:

- **Terraform**: Make sure you have Terraform installed. You can download it from [here](https://www.terraform.io/downloads.html).
- **AWS Account**: You need an AWS account to provision the infrastructure.
- **AWS CLI**: It's recommended to have AWS CLI installed to manage AWS credentials.
- **GitHub Account**: A GitHub account to interact with the GitHub repository and workflows.
- **IAM Permissions**: Ensure the AWS IAM user/role has appropriate permissions to create EKS, VPC, EC2, and related resources.

## Getting Started

### Clone the repository

Clone the repository to your local machine or configure it directly in your GitHub account:

```bash
git clone https://github.com/shahrukhshafique/infra.git
cd infra
```

### Setup AWS Credentials in GitHub Secrets

### Terraform Configuration