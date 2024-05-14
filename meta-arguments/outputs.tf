output "vm_ip" {
  value = azurerm_linux_virtual_machine.terraform_vm.public_ip_address
}
