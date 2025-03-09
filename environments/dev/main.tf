terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstate" # This will be updated after backend creation
    container_name      = "tfstate"
    key                = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-dev-main"
  location = "eastus2"
  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# Network Module
module "network" {
  source = "../../modules/network"

  vnet_name           = "vnet-dev-main"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]
  
  subnets = {
    "subnet-1" = "10.0.1.0/24"
    "subnet-2" = "10.0.2.0/24"
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
} 