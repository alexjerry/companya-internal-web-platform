
output "key_vault_role_assignment_id" {
  description = "ID of the Key Vault Secrets User role assignment."
  value       = azurerm_role_assignment.key_vault_secrets_user.id
}

output "storage_role_assignment_id" {
  description = "ID of the Storage Blob Data Contributor role assignment."
  value       = azurerm_role_assignment.storage_blob_data_contributor.id
}
