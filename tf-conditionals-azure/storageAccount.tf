resource "azurerm_resource_group" "resourceGroup" {
  name     = "RG-${var.env}"
  location = var.azure_location

  tags = local.common_tags
}

resource "azurerm_storage_account" "storage_account" {
  count                    = var.env == "dev" ? 0 : 1
  name                     = "rodrothbarth${var.env}"
  resource_group_name      = azurerm_resource_group.resourceGroup.name
  location                 = var.azure_location
  account_tier             = var.env == "prod" ? "Premium" : "Standard"
  account_replication_type = var.env == "prod" ? "RAGZRS" : "LRS"

  tags = local.common_tags
}

