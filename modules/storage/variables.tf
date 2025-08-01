# Required Variables
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "Primary location for the storage account (Central US for Texas)"
  type        = string
  default     = "southcentralus"

  validation {
    condition     = contains(["southcentralus", "eastus2"], var.location)
    error_message = "Location must be either southcentralus (Texas) or eastus2 (Virginia)"
  }
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique and follow naming convention)"
  type        = string

  # validation {
  #   condition     = can(regex("^stg[a-z]{3}[a-z]+[0-9]{3}$", var.storage_account_name))
  #   error_message = "Storage account name must follow pattern: stg<env><name><number> (e.g., stgdevtfstatefilemgmt001)"
  # }
}

# Tags and Metadata
variable "cost_center" {
  description = "Cost center for billing and tracking"
  type        = string
}

variable "application_name" {
  description = "Name of the application using this storage"
  type        = string
}

variable "owner" {
  description = "Owner or responsible team for the storage account"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to the storage account"
  type        = map(string)
  default     = {}
}

# Security and Network
variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain deleted blobs and containers"
  type        = number
  default     = 7

  validation {
    condition     = var.soft_delete_retention_days >= 1 && var.soft_delete_retention_days <= 365
    error_message = "Soft delete retention days must be between 1 and 365"
  }
}

# Monitoring
variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace for diagnostics"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain diagnostic logs"
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 1 && var.log_retention_days <= 365
    error_message = "Log retention days must be between 1 and 365"
  }
} 