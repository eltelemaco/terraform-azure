/**
 * # Log Analytics Workspace Module
 *
 * This module deploys an Azure Log Analytics Workspace and configures it for optimal log collection.
 * It provides centralized logging capabilities for Azure resources.
 *
 * ## Features
 * - Configurable retention period
 * - Daily quota management
 * - Internet ingestion and query enabled by default
 * - Customizable solutions and data sources
 * - Diagnostic settings for:
 *   - Azure Key Vault
 *   - Virtual Network
 *   - Subscription Activity Logs
 */

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  daily_quota_gb      = var.daily_quota_gb

  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  tags = var.tags
}

# Enable Azure Activity Log collection

# Key Vault Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "keyvault" {
  # count = var.key_vault_id != null && var.key_vault_id != "" ? 1 : 0

  name                       = "keyvault-diagnostics"
  target_resource_id         = var.key_vault_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category_group  = "allLogs"
  }

  metric {
    category = "AllMetrics"   
  }
}

# Virtual Network Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "vnet" {
  # count = var.vnet_id != null && var.vnet_id != "" ? 1 : 0

  name                       = "vnet-diagnostics"
  target_resource_id         = var.vnet_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category_group = "allLogs"
  }

  metric {
    category = "AllMetrics"    
  }
} 