/**
 * # Terraform Backend Configuration
 *
 * This configuration sets up the Azure Storage Account used for storing Terraform state files.
 * It creates the following resources:
 * - Resource Group for backend storage
 * - Storage Account with versioning enabled
 * - Storage Container for state files
 * - Role assignments for access
 *
 * ## Security Features
 * - TLS 1.2 enforced
 * - Blob versioning enabled
 * - Private container access
 * - GRS replication for disaster recovery
 *
 * ## Naming Convention
 * - Resource Group: rg-terraform-backend
 * - Storage Account: tfstate[random-string]
 * - Container: tfstate
 */

# Backend Resource Group
resource "azurerm_resource_group" "terraform_state" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Storage Account for Terraform State
resource "azurerm_storage_account" "terraform_state" {
  name                     = "tfstate${random_string.storage_account.result}"
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication
  min_tls_version         = "TLS1_2"

  blob_properties {
    versioning_enabled = true # Enables state file versioning
  }

  tags = var.tags
}

# Container for Terraform State Files
resource "azurerm_storage_container" "terraform_state" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.terraform_state.name
  container_access_type = "private" # Ensures private access only
}

# Random String for Storage Account Name
resource "random_string" "storage_account" {
  length  = 8
  special = false
  upper   = false
}

# Role Assignments for GitHub Actions
# resource "azurerm_role_assignment" "storage_blob_data_contributor" {
#   scope                = azurerm_storage_account.terraform_state.id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = "69604bd9-ce84-4969-9db0-288b8752ca9f"
# }

# resource "azurerm_role_assignment" "storage_blob_data_owner" {
#   scope                = azurerm_storage_account.terraform_state.id
#   role_definition_name = "Storage Blob Data Owner"
#   principal_id         = "69604bd9-ce84-4969-9db0-288b8752ca9f"
# } 