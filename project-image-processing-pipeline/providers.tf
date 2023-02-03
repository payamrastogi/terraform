terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
        random = {
            source = "hashicorp/random"
            version = "~> 3.3.0"
        }
        archive = {
            source  = "hashicorp/archive"
            version = "~> 2.2.0"
        }
    }

    required_version = "~> 1.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}