variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to access the Key Vault"
  type        = list(string)
  default     = []
} 