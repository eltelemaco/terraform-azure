# Azure AD Configuration
variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

# Key Vault Configuration
variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to access the Key Vault"
  type        = list(string)
  default     = []
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