#Virtual Machine
#-----------------------------------#
# Public IP for Virtual Machine     #
#-----------------------------------#

resource "azurerm_public_ip" "vm_pip" {
  count               = var.vm_count
  name                = format("vm-%s-pip-%s", count.index, var.location)
  location            = azurerm_resource_group.ng-host-vnet-rg.location
  resource_group_name = azurerm_resource_group.ng-host-vnet-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_network_interface" "nic0-vm" {
  count               = var.vm_count
  name                = format("nic0-gi1-inetv4-vm-%s-%s", count.index, var.location)
  location            = azurerm_resource_group.ng-host-vnet-rg.location
  resource_group_name = azurerm_resource_group.ng-host-vnet-rg.name

  ip_configuration {
    name                          = format("nic0-gi1-inetv4-vm-%s-%s", count.index, var.location)
    subnet_id                     = azurerm_subnet.inetv4-subnet-gi1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip[count.index].id
    primary                       = true
  }
  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count = var.vm_count

  name                  = format("linux-vm-%s-%s", count.index, var.location)
  location              = azurerm_resource_group.ng-host-vnet-rg.location
  resource_group_name   = azurerm_resource_group.ng-host-vnet-rg.name
  network_interface_ids = [azurerm_network_interface.nic0-vm[count.index].id]
  size                  = var.vm_size

  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false
  custom_data                     = filebase64("${path.module}/cloud-init.txt")

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = format("linux-vm-%s-%s-hdd", count.index, var.location)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" #"Premium_LRS"
  }

  tags = var.tags
}
