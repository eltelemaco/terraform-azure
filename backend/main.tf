terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

resource "azurerm_resource_group" "terraform_state" {
  name     = "rg-terraform-backend"
  location = "eastus2"
  tags = {
    Environment = "Management"
    Purpose     = "Terraform State"
  }
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = "tfstate${random_string.storage_account.result}"
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    Environment = "Management"
    Purpose     = "Terraform State"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private"
}

resource "random_string" "storage_account" {
  length  = 8
  special = false
  upper   = false
} 