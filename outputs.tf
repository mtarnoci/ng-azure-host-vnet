output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.host-vnet.id
}

output "vm_id" {
  description = "Virtual Machine ID"
  value       = azurerm_linux_virtual_machine.linux_vm.*.id
}

output "vm_private_ip" {
  description = "Virtual Machine Private IP"
  value       = azurerm_network_interface.nic0-vm.*.private_ip_address
}

output "vm_public_ip" {
  description = "Virtual Machine Public IP"
  value       = azurerm_public_ip.vm_pip.*
}