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
    key                  = "azure-vm-remote-module/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source              = "Azure/network/azurerm"
  version             = "5.2.0"
  resource_group_name = azurerm_resource_group.rg.name
  use_for_each        = true
  subnet_names        = ["subnet-${var.env}"]
  tags                = local.common_tags
  vnet_name           = "vnet-${var.env}"
  resource_group_location = var.azure-location
}
