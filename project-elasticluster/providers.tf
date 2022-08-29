terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }

    required_version = "~> 1.0"
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

locals {
  common_prefix = "demo"
  elk_domain = "${local.common_prefix}-elk-domain"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

