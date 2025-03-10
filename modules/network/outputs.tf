output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value       = { for name, subnet in azurerm_subnet.subnet : name => subnet.id }
}

output "vnet_address_space" {
  description = "The address space of the Virtual Network"
  value       = azurerm_virtual_network.vnet.address_space
} 