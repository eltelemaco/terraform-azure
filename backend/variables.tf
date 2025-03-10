variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "The Azure AD Tenant ID"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "environment" {
  description = "Environment name used for tagging"
  type        = string
  default     = "Management"
}

variable "resource_group_name" {
  description = "Name of the resource group for Terraform backend"
  type        = string
  default     = "rg-terraform-backend"
}

variable "storage_account_tier" {
  description = "Storage Account tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication" {
  description = "Storage Account replication type"
  type        = string
  default     = "GRS"
}

variable "container_name" {
  description = "Name of the storage container for Terraform state"
  type        = string
  default     = "container-tfstate"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Management"
    Purpose     = "Terraform State"
  }
} 