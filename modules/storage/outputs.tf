output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage_account.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint URL"
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The secondary blob endpoint URL (GRS)"
  value       = azurerm_storage_account.storage_account.secondary_blob_endpoint
}

output "primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.storage_account.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for the storage account"
  value       = azurerm_storage_account.storage_account.secondary_access_key
  sensitive   = true
}

output "container_ids" {
  description = "Map of container names to their IDs"
  value       = { for k, v in azurerm_storage_container.levels : k => v.id }
}

output "primary_location" {
  description = "The primary location of the storage account"
  value       = azurerm_storage_account.storage_account.location
}

output "secondary_location" {
  description = "The secondary location of the storage account (GRS)"
  value       = azurerm_storage_account.storage_account.secondary_location
} 