output "storage_account_id_canada" {
  value = azurerm_storage_account.storage_account["canada"].id
}

output "storage_account_id_eua" {
  value = azurerm_storage_account.storage_account["eua"].id
}

output "storage_account_id_brasil" {
  value = azurerm_storage_account.storage_account["brasil"].id
}

output "storage_account_id_asia" {
  value = azurerm_storage_account.storage_account["asia"].id
}

output "storage_account_access_key_canada" {
  value     = azurerm_storage_account.storage_account["canada"].primary_access_key
  sensitive = true
}

output "storage_account_access_key_asia" {
  value     = azurerm_storage_account.storage_account["asia"].primary_access_key
  sensitive = true
}

output "storage_account_access_key_brasil" {
  value     = azurerm_storage_account.storage_account["brasil"].primary_access_key
  sensitive = true
}

output "storage_account_access_key_eua" {
  value     = azurerm_storage_account.storage_account["eua"].primary_access_key
  sensitive = true
}
