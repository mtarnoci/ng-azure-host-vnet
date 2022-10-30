# Configure the azurerm provider source and version requirements
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.18"
    }
  }
}