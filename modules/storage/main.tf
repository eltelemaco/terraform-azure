/**
 * # Azure Storage Account Module
 *
 * This module deploys an Azure Storage Account with enterprise-grade features:
 * - Geo-redundant storage for high availability
 * - Premium storage tier
 * - Soft delete enabled
 * - Azure Storage Service Encryption
 * - Hierarchical blob containers (Level 0-3)
 * - Log Analytics integration
 * - State file locking capability
 *
 * ## Features
 * - Primary location: Central US (Texas)
 * - Secondary location: East US 2 (Virginia)
 * - Premium performance tier
 * - Standardized naming convention
 * - Comprehensive monitoring
 */

# Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Premium"
  account_replication_type = "GRS" # Geo-redundant storage
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"

  # Enable Hierarchical Namespace for advanced features
  is_hns_enabled = true

  # Enable Blob Service Features
  blob_properties {
    versioning_enabled       = true
    change_feed_enabled      = true
    last_access_time_enabled = true
    delete_retention_policy {
      days = var.soft_delete_retention_days
    }
    container_delete_retention_policy {
      days = var.soft_delete_retention_days
    }
  }

  # Network Rules
  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = var.allowed_ip_ranges
  }

  # Tags
  tags = merge(var.tags, {
    CostCenter      = var.cost_center
    ApplicationName = var.application_name
    Owner           = var.owner
  })
}

# Blob Containers for Different Levels
resource "azurerm_storage_container" "levels" {
  for_each = toset(["level0", "level1", "level2", "level3"])

  name                  = each.key
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}

# Diagnostic Settings for Log Analytics
resource "azurerm_monitor_diagnostic_setting" "storage" {
  name                       = "storage-diagnostics"
  target_resource_id         = azurerm_storage_account.storage_account.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"

  }

  metric {
    category = "Transaction"
    enabled  = true

  }

  metric {
    category = "Capacity"
    enabled  = true

  }
}

# Enable Advanced Threat Protection
resource "azurerm_advanced_threat_protection" "storage" {
  target_resource_id = azurerm_storage_account.storage_account.id
  enabled            = true
} 