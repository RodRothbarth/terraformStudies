resource "azurerm_resource_group" "rg" {
  name     = "terraform-vm-remote-module-${var.env}"
  location = var.azure-location
}

resource "azurerm_public_ip" "public_ip" {
  name                = "vm-terraform-ip-${var.env}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.azure-location
  allocation_method   = "Dynamic"

  tags = local.common_tags
}

resource "azurerm_network_interface" "nte_interface" {
  name                = "nic-terraform-${var.env}"
  location            = var.azure-location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = azurerm_public_ip.public_ip.name
    subnet_id                     = module.network.vnet_subnets[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "sg_association" {
  network_interface_id      = azurerm_network_interface.nte_interface.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "terraform_vm" {
  depends_on = [azurerm_network_interface_security_group_association.sg_association]

  name                = "terraform-machine-${var.env}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.azure-location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nte_interface.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("../../azure-terraform.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = local.common_tags
}
