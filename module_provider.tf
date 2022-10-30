# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  alias = "azure"

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}