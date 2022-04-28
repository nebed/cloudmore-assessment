terraform {
  backend "azurerm" {
    resource_group_name = "terraform"
    storage_account_name = "nebedterraform"
    container_name = "tfstate"
    key = "cloudmore/assessment.tfstate"
    subscription_id = "fdd0849c-e721-4449-afa2-3f64194af407"
    tenant_id = "e08e4203-21ec-4a41-ab58-cab52b59dc64"
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
  subscription_id = "fdd0849c-e721-4449-afa2-3f64194af407" 
  tenant_id = "e08e4203-21ec-4a41-ab58-cab52b59dc64"
}