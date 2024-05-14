resource "azurerm_resource_group" "resourceGroup" {
  for_each = var.azure-location

  name     = "RG-${each.key}"
  location = each.value

  tags = local.common_tags
}

resource "azurerm_storage_account" "storage_account" {
  for_each                 = azurerm_resource_group.resourceGroup
  name                     = "rodrothbarth${each.key}"
  resource_group_name      = each.value.name
  location                 = each.value.location
  account_tier             = var.azure_account_tier
  account_replication_type = var.azure_account_replication_type

  tags = local.common_tags
}


resource "azurerm_storage_container" "container" {
  for_each = azurerm_storage_account.storage_account

  name                 = "image-${each.key}"
  storage_account_name = each.value.name
}
