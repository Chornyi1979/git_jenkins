terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  
  subscription_id   = "$AZURE_SUBSCRIPTION_ID"
  tenant_id         = '7ab2df67-08b0-4840-940d-4cb97ddd5843'
  client_id         = "$AZURE_CLIENT_ID"
  client_secret     = "$AZURE_CLIENT_SECRET"
}

resource "azurerm_resource_group" "rm" {
  name     = "my-group-261179-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "rm" {
  name                = "alex-maven-terraform-plan"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name

  sku {
    tier = "Free"
    size = "F1"
  }
}
resource "azurerm_app_service" "rm" {
  name                = "alex-maven-terraform"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  app_service_plan_id = azurerm_app_service_plan.rm.id
}
resource "azurerm_virtual_network" "rm" {
  name                = "network-terraform"
  resource_group_name = azurerm_resource_group.rm.name
  location            = azurerm_resource_group.rm.location
  address_space       = ["10.0.0.0/16"]
}
