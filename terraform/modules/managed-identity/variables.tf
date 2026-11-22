
variable "name" {
  description = "Name of the User-Assigned Managed Identity."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where the Managed Identity will be created."
  type        = string
}

variable "location" {
  description = "Azure region where the Managed Identity will be created."
  type        = string
}

variable "tags" {
  description = "Tags applied to the Managed Identity."
  type        = map(string)
  default     = {}
}
