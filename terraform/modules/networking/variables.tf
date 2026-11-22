
variable "resource_group_name" {
  description = "Resource Group where networking resources will be deployed."
  type        = string
}

variable "location" {
  description = "Azure region for networking resources."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "Address space assigned to the Virtual Network."
  type        = list(string)
}

variable "app_subnet_name" {
  description = "Name of the App Service integration subnet."
  type        = string
}

variable "app_subnet_address_prefixes" {
  description = "Address prefixes for the App Service integration subnet."
  type        = list(string)
}

variable "private_endpoint_subnet_name" {
  description = "Name of the Private Endpoint subnet."
  type        = string
}

variable "private_endpoint_subnet_address_prefixes" {
  description = "Address prefixes for the Private Endpoint subnet."
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the application Network Security Group."
  type        = string
}

variable "tags" {
  description = "Tags applied to networking resources."
  type        = map(string)
  default     = {}
}
