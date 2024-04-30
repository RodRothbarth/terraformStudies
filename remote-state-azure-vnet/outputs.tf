output "subnetId" {
  value = azurerm_subnet.subnet.id
}

output "SGid" {
  value = azurerm_network_security_group.nsg.id
}
