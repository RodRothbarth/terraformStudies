resource "azurerm_resource_group" "vnet_resource_group" {
  name     = "vnet-resource-group"
  location = var.azure-location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "terraform-vnet"
  location            = var.azure-location
  resource_group_name = azurerm_resource_group.vnet_resource_group.name
  address_space       = ["10.0.0.0/16"]

  tags = local.common_tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "terraform-subnet"
  resource_group_name  = azurerm_resource_group.vnet_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_network_security_group" "nsg" {
  name                = "terraform-nsg"
  location            = var.azure-location
  resource_group_name = azurerm_resource_group.vnet_resource_group.name

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
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
