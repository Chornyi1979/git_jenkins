terraform {
  required_version = ">=3.0.0"
  
  backend "azurerm" {
    resource_group_name = "my-group-261179-rg"
    storage_account_name = "ch2611"
    container_name       = "tfstate-maven"
    key                  = "terraform.tfstate-maven"

    features{
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "rm" {
  name     = "my-group-261179-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "rm" {
  name                = "alex-webapp-terraform-plan"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name

  sku {
    tier = "Free"
    size = "F1"
  }
}
resource "azurerm_app_service" "rm" {
  name                = "alex-webapp-terraform"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  app_service_plan_id = azurerm_app_service_plan.rm.id
}
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}
