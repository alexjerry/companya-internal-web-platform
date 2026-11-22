
output "key_vault_id" {
  description = "Resource ID of the Azure Key Vault."
  value       = azurerm_key_vault.this.id
}

output "key_vault_name" {
  description = "Name of the Azure Key Vault."
  value       = azurerm_key_vault.this.name
}

output "key_vault_uri" {
  description = "URI of the Azure Key Vault."
  value       = azurerm_key_vault.this.vault_uri
}

output "private_endpoint_id" {
  description = "Resource ID of the Key Vault Private Endpoint."
  value       = azurerm_private_endpoint.key_vault.id
}

output "private_endpoint_private_ip" {
  description = "Private IP address of the Key Vault Private Endpoint."
  value       = azurerm_private_endpoint.key_vault.private_service_connection[0].private_ip_address
}
