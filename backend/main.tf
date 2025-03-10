/**
 * # Terraform Backend Configuration
 *
 * This configuration sets up the Azure Storage Account used for storing Terraform state files.
 * It creates the following resources:
 * - Resource Group for backend storage
 * - Storage Account with versioning enabled
 * - Storage Container for state files
 *
 * ## Security Features
 * - TLS 1.2 enforced
 * - Blob versioning enabled
 * - Private container access
 * - GRS replication for disaster recovery
 *
 * ## Naming Convention
 * - Resource Group: rg-terraform-backend
 * - Storage Account: tfstate[random-string]
 * - Container: tfstate
 */

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

# Backend Resource Group
resource "azurerm_resource_group" "terraform_state" {
  name     = "rg-terraform-backend"
  location = "eastus2"
  tags = {
    Environment = "Management"
    Purpose     = "Terraform State"
  }
}

# Storage Account for Terraform State
resource "azurerm_storage_account" "terraform_state" {
  name                     = "tfstate${random_string.storage_account.result}"
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true # Enables state file versioning
  }

  tags = {
    Environment = "Management"
    Purpose     = "Terraform State"
  }
}

# Container for Terraform State Files
resource "azurerm_storage_container" "terraform_state" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private" # Ensures private access only
}

# Random String for Storage Account Name
resource "random_string" "storage_account" {
  length  = 8
  special = false
  upper   = false
} 