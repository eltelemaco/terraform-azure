resource "azurerm_key_vault" "vault" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                   = "standard"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = var.allowed_ip_ranges
  }

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "policy" {
  for_each = var.access_policies

  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = var.tenant_id
  object_id    = each.value.object_id

  key_permissions = each.value.key_permissions
  secret_permissions = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
} 