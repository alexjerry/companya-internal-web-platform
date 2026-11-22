
variable "subscription_id" {
  description = "Azure subscription ID where the platform will be deployed."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.subscription_id))
    error_message = "The subscription_id must be a valid GUID."
  }
}

variable "location" {
  description = "Azure region for the platform deployment."
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Short project identifier used in resource naming."
  type        = string
  default     = "companya"
}

variable "resource_group_name" {
  description = "Name of the main application resource group."
  type        = string
  default     = "rg-companya-platform-prod"
}

variable "vnet_address_space" {
  description = "Address space assigned to the virtual network."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "tags" {
  description = "Common tags applied to Azure resources."
  type        = map(string)
  default = {
    project     = "companya-internal-web-platform"
    environment = "prod"
    managed_by  = "terraform"
  }
}


variable "app_subnet_address_prefixes" {
  description = "Address prefixes for the App Service integration subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "private_endpoint_subnet_address_prefixes" {
  description = "Address prefixes for the Private Endpoint subnet."
  type        = list(string)
  default     = ["10.20.2.0/24"]
}


variable "app_service_plan_sku" {
  description = "SKU of the production App Service Plan."
  type        = string
  default     = "P1v3"
}


variable "key_vault_name" {
  description = "Globally unique Azure Key Vault name."
  type        = string
}


variable "storage_account_name" {
  description = "Globally unique Azure Storage Account name."
  type        = string
}


variable "log_analytics_workspace_name" {
  description = "Name of the production Log Analytics Workspace."
  type        = string
}

variable "application_insights_name" {
  description = "Name of the production Application Insights resource."
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Log Analytics data retention period in days."
  type        = number
  default     = 30
}


variable "company_readers_group_object_id" {
  description = "Object ID of the existing COMPANYA_READERS security group."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.company_readers_group_object_id))
    error_message = "The readers group object ID must be a valid GUID."
  }
}

variable "company_writers_group_object_id" {
  description = "Object ID of the existing COMPANYA_WRITERS security group."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.company_writers_group_object_id))
    error_message = "The writers group object ID must be a valid GUID."
  }
}
