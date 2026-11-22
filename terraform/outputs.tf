
output "resource_group_name" {
  description = "Name of the application Resource Group."
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "Resource ID of the application Resource Group."
  value       = module.resource_group.resource_group_id
}

output "virtual_network_id" {
  description = "Resource ID of the application Virtual Network."
  value       = module.networking.vnet_id
}

output "virtual_network_name" {
  description = "Name of the application Virtual Network."
  value       = module.networking.vnet_name
}

output "app_service_name" {
  description = "Name of the Linux Web App."
  value       = module.app_service.web_app_name
}

output "app_service_default_hostname" {
  description = "Default hostname of the Web App. Public access is disabled."
  value       = module.app_service.web_app_default_hostname
}

output "key_vault_name" {
  description = "Name of the Key Vault."
  value       = module.key_vault.key_vault_name
}

output "key_vault_uri" {
  description = "URI of the Key Vault."
  value       = module.key_vault.key_vault_uri
}

output "storage_account_name" {
  description = "Name of the Storage Account."
  value       = module.storage.storage_account_name
}

output "storage_blob_endpoint" {
  description = "Blob service endpoint."
  value       = module.storage.primary_blob_endpoint
}

output "managed_identity_name" {
  description = "Name of the shared User-Assigned Managed Identity."
  value       = module.managed_identity.name
}

output "managed_identity_principal_id" {
  description = "Principal ID of the shared User-Assigned Managed Identity."
  value       = module.managed_identity.principal_id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace."
  value       = module.monitoring.log_analytics_workspace_name
}

output "application_insights_name" {
  description = "Name of the Application Insights resource."
  value       = module.monitoring.application_insights_name
}

output "app_service_private_endpoint_ip" {
  description = "Private IP address assigned to the App Service private endpoint."
  value       = module.app_service.private_endpoint_private_ip
}

output "key_vault_private_endpoint_ip" {
  description = "Private IP address assigned to the Key Vault private endpoint."
  value       = module.key_vault.private_endpoint_private_ip
}

output "storage_private_endpoint_ip" {
  description = "Private IP address assigned to the Storage private endpoint."
  value       = module.storage.private_endpoint_private_ip
}

output "monitor_private_endpoint_ip" {
  description = "Private IP address assigned to the Azure Monitor private endpoint."
  value       = module.monitor_private_link.private_endpoint_private_ip
}
