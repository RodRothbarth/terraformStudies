terraform {
  required_version = ">1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.101.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rodrothbarth-remote-state"
    storage_account_name = "rodrothbarthstoraccount"
    container_name       = "rodrothbarth-remotestate"
    key                  = "azure-forEach/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
