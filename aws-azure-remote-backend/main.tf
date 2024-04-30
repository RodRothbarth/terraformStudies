terraform {
  required_version = ">1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.101.0"
    }
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

provider "azurerm" {
  features {}
}
