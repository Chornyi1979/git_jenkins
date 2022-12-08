terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = "tfstate-maven"
        storage_account_name = "ch261179"
        container_name       = "tfstate"
        key                  = "prod.tfstate.terraform"
        use_azuread_auth     = true
        subscription_id      = "6c57c00d-ac27-409b-9fc2-dd266529f436"
        tenant_id            = "7ab2df67-08b0-4840-940d-4cb97ddd5843"
	access_key           = "$ACCOUNT_KEY"
    }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  
  subscription_id   = "6c57c00d-ac27-409b-9fc2-dd266529f436"
  tenant_id         = "7ab2df67-08b0-4840-940d-4cb97ddd5843"
  client_id         = "803250fd-31a3-4d06-a481-263973ed3e77"
  client_secret     = "r9a8Q~ZTnK-nqMpA68uZeDiLnuY9DVljeX3imbP."
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
