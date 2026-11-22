
output "id" {
  description = "Resource ID of the User-Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.id
}

output "name" {
  description = "Name of the User-Assigned Managed Identity."
  value       = azurerm_user_assigned_identity.this.name
}

output "client_id" {
  description = "Client ID used by applications to authenticate with this identity."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "principal_id" {
  description = "Principal ID used for Azure RBAC role assignments."
  value       = azurerm_user_assigned_identity.this.principal_id
}
