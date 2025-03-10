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
resource "azurerm_monitor_diagnostic_setting" "subscription" {
  count = var.enable_activity_logs ? 1 : 0

  name               = "subscription-logs"
  target_resource_id = "/subscriptions/${var.subscription_id}"

  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "Administrative"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "ServiceHealth"
  }

  enabled_log {
    category = "Alert"
  }

  enabled_log {
    category = "Recommendation"
  }

  enabled_log {
    category = "Policy"
  }

  enabled_log {
    category = "Autoscale"
  }

  enabled_log {
    category = "ResourceHealth"
  }
}

# Key Vault Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "keyvault" {
  count = var.key_vault_id != null && var.key_vault_id != "" ? 1 : 0

  name                       = "keyvault-diagnostics"
  target_resource_id         = var.key_vault_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "AuditEvent"
  }

  enabled_log {
    category = "AzurePolicyEvaluationDetails"
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.retention_in_days
    }
  }
}

# Virtual Network Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "vnet" {
  count = var.vnet_id != null && var.vnet_id != "" ? 1 : 0

  name                       = "vnet-diagnostics"
  target_resource_id         = var.vnet_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "VMProtectionAlerts"
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.retention_in_days
    }
  }
} 