
variable "name" {
  description = "Name of the Azure Monitor Private Link Scope."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group containing the Azure Monitor Private Link resources."
  type        = string
}

variable "location" {
  description = "Azure region for the Private Endpoint."
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the VNet linked to Azure Monitor Private Link."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "ID of the subnet hosting the Azure Monitor Private Endpoint."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "ID of the existing Log Analytics Workspace."
  type        = string
}

variable "tags" {
  description = "Common tags applied to Azure resources."
  type        = map(string)
  default     = {}
}


variable "application_insights_id" {
  description = "ID of the existing Application Insights component."
  type        = string
}

variable "storage_blob_private_dns_zone_id" {
  description = "ID of the existing Blob Storage private DNS zone."
  type        = string
}
