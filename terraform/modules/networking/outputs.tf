
output "vnet_id" {
  description = "Resource ID of the Virtual Network."
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the Virtual Network."
  value       = azurerm_virtual_network.this.name
}

output "app_subnet_id" {
  description = "Resource ID of the App Service integration subnet."
  value       = azurerm_subnet.app.id
}

output "private_endpoint_subnet_id" {
  description = "Resource ID of the Private Endpoint subnet."
  value       = azurerm_subnet.private_endpoints.id
}

output "nsg_id" {
  description = "Resource ID of the application Network Security Group."
  value       = azurerm_network_security_group.app.id
}

output "nsg_name" {
  description = "Name of the application Network Security Group."
  value       = azurerm_network_security_group.app.name
}
