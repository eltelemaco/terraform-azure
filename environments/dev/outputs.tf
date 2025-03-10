/**
 * # Development Environment Outputs
 *
 * This file defines all outputs from the development environment deployment.
 * These outputs can be used for:
 * - Integration with other tools
 * - Documentation
 * - Dependencies in other Terraform configurations
 *
 * ## Output Categories
 * - Resource Group: Basic resource group information
 * - Network: VNet and subnet details
 * - Key Vault: Vault identifiers and access information
 */

# Resource Group Outputs
output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = module.resource_group.resource_group_id
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = module.resource_group.resource_group_location
}

# Network Outputs
output "vnet_name" {
  description = "The name of the virtual network"
  value       = module.network.vnet_name
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = module.network.subnet_ids
  sensitive   = false
}

# Key Vault Outputs
output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = module.keyvault.key_vault_id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault"
  value       = module.keyvault.key_vault_uri
  sensitive   = true # URI might contain sensitive information
}

output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = module.keyvault.key_vault_name
} 