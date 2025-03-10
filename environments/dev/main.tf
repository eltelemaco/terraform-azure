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
    storage_account_name = "tfstatereb80hkq"
    container_name       = "container-tfstate"
    key                  = "dev.terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

# Resource Group Module
module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = "rg-dev-main"
  location            = "eastus2"
  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# Network Module - Creates Virtual Network and Subnets
module "network" {
  source = "../../modules/network"

  vnet_name           = "vnet-dev-main"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = ["10.0.0.0/16"]

  # Subnet configuration
  subnets = {
    "subnet-1" = "10.0.1.0/24" # Application subnet
    "subnet-2" = "10.0.2.0/24" # Database subnet
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# Key Vault Module - Secure secret management
module "keyvault" {
  source = "../../modules/keyvault"

  key_vault_name      = "kv-dev-main"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  tenant_id           = var.tenant_id

  allowed_ip_ranges = var.allowed_ip_ranges

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
} 