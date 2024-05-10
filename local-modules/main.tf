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
    key    = "aws-local-modules/terraform.tfstate"
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

module "network" {
  source      = "./network"
  aws-region  = "us-east-1"
  cidr_vpc    = "10.0.0.0/16"
  cidr_subnet = "10.0.1.0/24"
  env_name    = var.env
}
