/**
 * # Azure Resource Group Module
 *
 * This module creates an Azure Resource Group with standardized naming and tagging.
 *
 * ## Usage
 * ```hcl
 * module "resource_group" {
 *   source = "../../modules/resource_group"
 *
 *   resource_group_name = "rg-dev-main"
 *   location           = "eastus2"
 *   tags = {
 *     Environment = "Development"
 *     ManagedBy   = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Features
 * - Standardized resource group creation
 * - Flexible tagging system
 * - Location specification
 * - Outputs for resource group properties
 */

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
} 