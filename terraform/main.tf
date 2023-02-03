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

        access_key           = "A27nITkJWj2kTIhdweo0gIxTEP/l5pFnpwOor9d/3KtApgJWpm0uM3XyAI3c0IJqWOYuHVncZEAG+AStb0pPXQ=="
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
  branch             = "master"
  use_manual_integration = true
  use_mercurial      = false
}
