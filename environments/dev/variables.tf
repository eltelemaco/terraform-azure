# Environment Configuration
variable "environment" {
  description = "The environment name (dev, prod, etc.)"
  type        = string
  default     = "dev"
}

# Azure Authentication - OIDC Authentication
variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

# Azure AD Configuration - OIDC Authentication
variable "tenant_id" {
  description = "The Azure AD Tenant ID"
  type        = string
}

# Key Vault Configuration - OIDC Authentication
variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to access the Key Vault"
  type        = list(string)
  default     = []
}

# Resource Group Configuration
variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "southcentralus"
}

variable "resource_group_name" {
  description = "Name of the main resource group"
  type        = string
  default     = "rg-dev-main"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "stgdevtdemomgmt001" #stg<env><name><number>
}

# Network Configuration
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-dev-main"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnet names to address prefixes"
  type        = map(string)
  default = {
    "subnet-1" = "10.0.1.0/24" # Application subnet
    "subnet-2" = "10.0.2.0/24" # Database subnet
  }
}

# Key Vault Configuration
variable "key_vault_name" {
  description = "Name of the key vault"
  type        = string
  default     = "kv-dev-main"
}

# Common Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# Backend Configuration
variable "backend_resource_group_name" {
  description = "Resource group name for the backend storage"
  type        = string
}

variable "backend_storage_account_name" {
  description = "Storage account name for the backend"
  type        = string
}

variable "backend_container_name" {
  description = "Container name for the backend storage"
  type        = string
}

variable "backend_key" {
  description = "State file name in the backend storage"
  type        = string
} 