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

      
    }
} 


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  
 
}

resource "azurerm_resource_group" "rm" {
  name     = "my-group-261179-rg"
  location = "East US"
}

resource "azurerm_service_plan" "rm" {
  name                = "alex-maven-terraform-plan"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  os_type             = "Linux"
  sku_name            = "P1v2"

}

resource "azurerm_linux_web_app" "rm" {
  name                = "alex-maven-terraform"
  location            = azurerm_resource_group.rm.location
  resource_group_name = azurerm_resource_group.rm.name
  service_plan_id     = azurerm_service_plan.rm.id
  
  site_config {
    
    application_stack {
      java_server = "JAVA"
      java_server_version = 8
      java_version = "java8"
    }
  }
  
  
  
}

resource "azurerm_virtual_network" "rm" {
  name                = "network-terraform"
  resource_group_name = azurerm_resource_group.rm.name
  location            = azurerm_resource_group.rm.location
  address_space       = ["10.0.0.0/16"]
}
#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.rm.id
  repo_url           = "https://github.com/Chornyi1979/git_jenkins.git"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
}
