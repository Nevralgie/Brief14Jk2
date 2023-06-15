terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.58.0"
    }
  }
}

provider "azurerm" {
   subscription_id = var.subscription_id
   client_id = var.client_id
   client_secret = var.client_secret
   tenant_id = var.tenant_id
   skip_provider_registration = true
   features {}
}

module "azure-webserver" {
    source = "github.com/Nevralgie/Brief14Jk2/azure-webserver/"
    environment = var.environment
}

resource "azurerm_resource_group" "webserver" {
   name = "Brief14Jkstage"
   location = var.location
}
