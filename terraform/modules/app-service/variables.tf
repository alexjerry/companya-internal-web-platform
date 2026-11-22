
variable "resource_group_name" {
  description = "Resource Group where App Service resources will be created."
  type        = string
}

variable "location" {
  description = "Azure region for App Service resources."
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan."
  type        = string
}

variable "app_name" {
  description = "Name of the Linux Web App."
  type        = string
}

variable "app_service_plan_sku" {
  description = "SKU of the App Service Plan."
  type        = string
  default     = "P1v3"
}

variable "integration_subnet_id" {
  description = "Subnet ID used for App Service VNet Integration."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID used for the App Service Private Endpoint."
  type        = string
}

variable "managed_identity_id" {
  description = "Resource ID of the User-Assigned Managed Identity."
  type        = string
}

variable "web_app_private_dns_zone_id" {
  description = "Resource ID of the App Service Private DNS Zone."
  type        = string
}

variable "tags" {
  description = "Tags applied to App Service resources."
  type        = map(string)
  default     = {}
}


variable "key_vault_uri" {
  description = "URI of the Key Vault used by the application."
  type        = string
}

variable "storage_blob_endpoint" {
  description = "Blob service endpoint used by the application."
  type        = string
}

variable "managed_identity_client_id" {
  description = "Client ID of the User-Assigned Managed Identity."
  type        = string
}
variable "application_insights_connection_string" {
  description = "Connection string for the workspace-based Application Insights resource."
  type        = string
  sensitive   = true
}