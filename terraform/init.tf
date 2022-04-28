terraform {
  backend "azurerm" {
    resource_group_name = "terraform"
    storage_account_name = "nebedterraform"
    container_name = "tfstate"
    key = "cloudmore/assessment.tfstate"
    subscription_id = "xxxxxxxxxxxxxxx"
    tenant_id = "xxxxxxxxxxxxxxx"
}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id = local.tenant_id
  subscription_id = local.subscription_id
}

locals {
  subscription_id = "xxxxxxxxxxxxxxx" 
  tenant_id = "xxxxxxxxxxxxxxx"
}