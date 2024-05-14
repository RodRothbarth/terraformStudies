resource "azurerm_network_security_group" "nsg" {
  name                = "terraform-nsg-${var.env}"
  location            = var.azure-location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = local.common_tags
}

resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = module.network.vnet_subnets[0]
  network_security_group_id = azurerm_network_security_group.nsg.id
}
