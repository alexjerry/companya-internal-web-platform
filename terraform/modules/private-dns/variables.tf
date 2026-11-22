
variable "resource_group_name" {
  description = "Resource Group where Private DNS Zones will be created."
  type        = string
}

variable "virtual_network_id" {
  description = "Resource ID of the Virtual Network linked to the Private DNS Zones."
  type        = string
}

variable "tags" {
  description = "Tags applied to supported resources."
  type        = map(string)
  default     = {}
}
