resource "azurerm_resource_group" "resourceGroup" {
  name     = var.resource_group_name
  location = var.azure_location

  tags = local.common_tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.resourceGroup.name
  location                 = var.azure_location
  account_tier             = var.azure_account_tier
  account_replication_type = var.azure_account_replication_type

  tags = local.common_tags
}


resource "azurerm_storage_container" "container" {
  name                 = var.container
  storage_account_name = azurerm_storage_account.storage_account.name
}
