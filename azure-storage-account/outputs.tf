output "storage_account_id" {
  value = azurerm_storage_account.storage_account.id
}

output "storage_account_access_key" {
  value     = azurerm_storage_account.storage_account.primary_access_key
  sensitive = true
}
