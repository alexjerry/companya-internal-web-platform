
variable "storage_account_name" {
  description = "Globally unique name of the Azure Storage Account. Use lowercase letters and numbers only."
  type        = string

  validation {
    condition = (
      length(var.storage_account_name) >= 3 &&
      length(var.storage_account_name) <= 24 &&
      can(regex("^[a-z0-9]+$", var.storage_account_name))
    )
    error_message = "The Storage Account name must contain 3 to 24 lowercase letters or numbers only."
  }
}

variable "resource_group_name" {
  description = "Resource Group where the Storage Account will be created."
  type        = string
}

variable "location" {
  description = "Azure region where the Storage Account will be created."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID used for the Blob Storage Private Endpoint."
  type        = string
}

variable "private_dns_zone_id" {
  description = "Resource ID of the Blob Storage Private DNS Zone."
  type        = string
}

variable "tags" {
  description = "Tags applied to Storage resources."
  type        = map(string)
  default     = {}
}
variable "container_name" {
  description = "Name of the private Blob container used by the application."
  type        = string
  default     = "documents"
}