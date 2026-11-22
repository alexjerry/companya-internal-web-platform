
output "key_vault_private_dns_zone_id" {
  description = "Resource ID of the Key Vault Private DNS Zone."
  value       = azurerm_private_dns_zone.key_vault.id
}

output "storage_blob_private_dns_zone_id" {
  description = "Resource ID of the Storage Blob Private DNS Zone."
  value       = azurerm_private_dns_zone.storage_blob.id
}

output "key_vault_private_dns_zone_name" {
  description = "Name of the Key Vault Private DNS Zone."
  value       = azurerm_private_dns_zone.key_vault.name
}

output "storage_blob_private_dns_zone_name" {
  description = "Name of the Storage Blob Private DNS Zone."
  value       = azurerm_private_dns_zone.storage_blob.name
}


output "web_app_private_dns_zone_id" {
  description = "Resource ID of the App Service Private DNS Zone."
  value       = azurerm_private_dns_zone.web_app.id
}
