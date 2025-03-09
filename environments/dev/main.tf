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

# Key Vault Module
module "keyvault" {
  source = "../../modules/keyvault"

  key_vault_name      = "kv-dev-main"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tenant_id          = var.tenant_id

  allowed_ip_ranges = var.allowed_ip_ranges

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# App Service Module
module "app_service" {
  source = "../../modules/app_service"

  service_plan_name   = "plan-dev-main"
  app_name           = "app-dev-main"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type            = "Linux"
  sku_name           = "B1"

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://index.docker.io"
  }

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
} 