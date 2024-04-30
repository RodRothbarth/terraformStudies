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
    key    = "aws-vpc/terraform.tfstate"
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
