/**
 * # Development Environment Configuration
 * 
 * This configuration represents the development environment infrastructure in Azure.
 * It uses modules to create and manage the following resources:
 * - Resource Group
 * - Virtual Network with subnets
 * - Key Vault with access policies
 *
 * ## Required Providers
 * - Azure RM Provider ~> 3.0
 *
 * ## Backend Configuration
 * Uses Azure Storage Account for state management with the following settings:
 * - Resource Group: rg-terraform-backend
 * - Container: container-tfstate
 * - State File: dev.terraform.tfstate
 *
 * ## Tags
 * All resources are tagged with:
 * - Environment = "Development"
 * - ManagedBy = "Terraform"
 */

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "tfstategp2ej81f"
    container_name       = "container-tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  # OIDC Configuration
  use_oidc        = true
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Resource Group Module
module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Network Module - Creates Virtual Network and Subnets
module "network" {
  source = "../../modules/network"

  vnet_name           = var.vnet_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = var.tags
}

# Key Vault Module - Secure secret management
module "keyvault" {
  source = "../../modules/keyvault"

  key_vault_name      = var.key_vault_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  tenant_id           = var.tenant_id
  allowed_ip_ranges   = var.allowed_ip_ranges
  tags                = var.tags
} 