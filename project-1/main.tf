terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}


## How to refresh the state of the terraform if the state file is deleted???
resource "aws_vpc" "vpc-20220824-01" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-20220824-01"
  }
}

resource "aws_subnet" "subnet-20220824-01" {
  vpc_id     = aws_vpc.vpc-20220824-01.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-20220824-01"
  }
}

resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"

  tags = {
    Name = "ubuntu_instance_20220823"
  }
}