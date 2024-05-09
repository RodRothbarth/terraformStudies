terraform {
  required_version = ">1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
  }
  backend "s3" {
    bucket = "rodrothbarth-remote-state"
    region = "us-east-1"
    key    = "aws-ec2-userData/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Ambiente   = "Teste"
      managed-by = "Terraform"
    }
  }
}

data "terraform_remote_state" "remote_state_vpc" {
  backend = "s3"
  config = {
    bucket = "rodrothbarth-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
