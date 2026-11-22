
output "key_vault_diagnostic_setting_id" {
  description = "ID of the Key Vault diagnostic setting."
  value       = azurerm_monitor_diagnostic_setting.key_vault.id
}

output "web_app_diagnostic_setting_id" {
  description = "ID of the App Service diagnostic setting."
  value       = azurerm_monitor_diagnostic_setting.web_app.id
}

output "storage_blob_diagnostic_setting_id" {
  description = "ID of the Storage Blob diagnostic setting."
  value       = azurerm_monitor_diagnostic_setting.storage_blob.id
}
