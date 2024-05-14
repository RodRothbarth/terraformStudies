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
    key    = "aws-provider-meta/terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws-region
  default_tags {
    tags = {
      Ambiente   = "Teste"
      managed-by = "Terraform"
    }
  }
}

provider "aws" {
  alias = "west"
  region = "us-west-1"
  default_tags {
    tags = {
      Ambiente   = "Teste"
      managed-by = "Terraform"
    }
  }
}

provider "aws" {
  alias = "central"
  region = "us-central-1"
  default_tags {
    tags = {
      Ambiente   = "Teste"
      managed-by = "Terraform"
    }
  }
}

module "vpc" {
  providers = {
    aws.provider1 = aws.central
    aws.provider2 = aws.west
  }
  source = "./vpc"
}


