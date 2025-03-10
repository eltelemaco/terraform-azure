/**
 * # Backend Infrastructure Outputs
 * 
 * These outputs provide essential information about the backend infrastructure
 * for use in other Terraform configurations and documentation.
 */

# Resource Group Outputs
output "resource_group_name" {
  description = "The name of the backend resource group"
  value       = azurerm_resource_group.terraform_state.name
}

output "resource_group_location" {
  description = "The location of the backend resource group"
  value       = azurerm_resource_group.terraform_state.location
}

# Storage Account Outputs
output "storage_account_name" {
  description = "The name of the storage account for Terraform state"
  value       = azurerm_storage_account.terraform_state.name
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.terraform_state.id
}

# Container Outputs
output "container_name" {
  description = "The name of the storage container for Terraform state"
  value       = azurerm_storage_container.terraform_state.name
}

# Backend Configuration Values
output "backend_configuration" {
  description = "Backend configuration values for other Terraform configurations"
  value = {
    resource_group_name  = azurerm_resource_group.terraform_state.name
    storage_account_name = azurerm_storage_account.terraform_state.name
    container_name      = azurerm_storage_container.terraform_state.name
    key                 = "terraform.tfstate"
  }
} 