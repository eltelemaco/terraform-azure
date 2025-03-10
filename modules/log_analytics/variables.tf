variable "workspace_name" {
  description = "The name of the Log Analytics Workspace"
  type        = string
}

variable "location" {
  description = "The Azure region where the Log Analytics Workspace should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Log Analytics Workspace should be created"
  type        = string
}

variable "sku" {
  description = "The SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The number of days to retain logs"
  type        = number
  default     = 30

  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "Retention days must be between 30 and 730 days."
  }
}

variable "daily_quota_gb" {
  description = "The workspace daily quota for ingestion in GB"
  type        = number
  default     = 1

  validation {
    condition     = var.daily_quota_gb > 0
    error_message = "Daily quota must be greater than 0 GB."
  }
}

variable "internet_ingestion_enabled" {
  description = "Should the workspace support ingestion over the Public Internet?"
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Should the workspace support querying over the Public Internet?"
  type        = bool
  default     = true
}

variable "enable_activity_logs" {
  description = "Should Azure Activity Logs be collected for the subscription?"
  type        = bool
  default     = true
}

variable "subscription_id" {
  description = "The subscription ID where the Log Analytics Workspace is created"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault to collect diagnostic settings from"
  type        = string
  default     = null
}

variable "vnet_id" {
  description = "The ID of the Virtual Network to collect diagnostic settings from"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the Log Analytics Workspace"
  type        = map(string)
  default     = {}
} 