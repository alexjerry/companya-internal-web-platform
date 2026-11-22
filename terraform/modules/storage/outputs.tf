
output "storage_account_id" {
  description = "Resource ID of the Storage Account."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Name of the Storage Account."
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob Storage endpoint."
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "private_endpoint_id" {
  description = "Resource ID of the Blob Storage Private Endpoint."
  value       = azurerm_private_endpoint.blob.id
}

output "private_endpoint_private_ip" {
  description = "Private IP address of the Blob Storage Private Endpoint."
  value       = azurerm_private_endpoint.blob.private_service_connection[0].private_ip_address
}

output "container_id" {
  description = "Resource ID of the application Blob container."
  value       = azurerm_storage_container.documents.id
}


output "container_name" {
  description = "Name of the application Blob container."
  value       = azurerm_storage_container.documents.name
}