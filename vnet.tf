
resource "azurerm_resource_group" "ng-host-vnet-rg" {
  provider = azurerm.azure
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "host-vnet" {
  provider = azurerm.azure
  name                = var.vnet_name
  location            = azurerm_resource_group.ng-host-vnet-rg.location
  resource_group_name = azurerm_resource_group.ng-host-vnet-rg.name
  address_space       = var.cidr
  tags                = var.tags
}

resource "azurerm_network_security_group" "ipl_inbound" {
  provider = azurerm.azure
  name                = var.sg_name
  location            = azurerm_resource_group.ng-host-vnet-rg.location
  resource_group_name = azurerm_resource_group.ng-host-vnet-rg.name

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

  security_rule {
    name                       = "http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "https"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "icmp"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "0"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "ipl_inbound" {
  provider = azurerm.azure
  subnet_id                 = azurerm_subnet.inetv4-subnet-gi1.id
  network_security_group_id = azurerm_network_security_group.ipl_inbound.id
}

resource "azurerm_subnet" "inetv4-subnet-gi1" {
  provider = azurerm.azure
  name                 = var.inet_subnet_name
  resource_group_name  = azurerm_resource_group.ng-host-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.host-vnet.name
  address_prefixes     = var.cidr_subnet
}