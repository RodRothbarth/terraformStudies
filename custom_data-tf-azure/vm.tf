resource "azurerm_resource_group" "rg" {
  name     = "terraform-vm"
  location = var.azure-location
}

resource "azurerm_public_ip" "public_ip" {
  name                = "vm-terraform-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.azure-location
  allocation_method   = "Dynamic"

  tags = local.common_tags
}

resource "azurerm_network_interface" "nte_interface" {
  name                = "nic-terraform"
  location            = var.azure-location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = azurerm_public_ip.public_ip.name
    subnet_id                     = data.terraform_remote_state.vnet-remote-data.outputs.subnetId
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  tags = local.common_tags
}

resource "azurerm_network_interface_security_group_association" "sg_association" {
  network_interface_id      = azurerm_network_interface.nte_interface.id
  network_security_group_id = data.terraform_remote_state.vnet-remote-data.outputs.SGid
}

resource "azurerm_linux_virtual_machine" "terraform_vm" {
  name                = "terraform-machine"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.azure-location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nte_interface.id,
  ]
  custom_data = base64encode(file("./init-scripts/docker.sh"))

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
