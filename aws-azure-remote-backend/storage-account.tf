resource "azurerm_resource_group" "resource_group" {
  name     = var.storage
  location = var.azure-location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "rodrothbarthstoraccount"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }

  tags = local.common_tags
}

resource "azurerm_storage_container" "example" {
  name                  = "rodrothbarth-remotestate"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}
