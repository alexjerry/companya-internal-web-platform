
variable "name" {
  description = "Globally unique name of the Azure Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where Key Vault will be created."
  type        = string
}

variable "location" {
  description = "Azure region where Key Vault will be created."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID associated with the Key Vault."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID used for the Key Vault Private Endpoint."
  type        = string
}

variable "private_dns_zone_id" {
  description = "Resource ID of the Key Vault Private DNS Zone."
  type        = string
}

variable "tags" {
  description = "Tags applied to Key Vault resources."
  type        = map(string)
  default     = {}
}
