
variable "managed_identity_principal_id" {
  description = "Principal ID of the User-Assigned Managed Identity."
  type        = string
}

variable "key_vault_id" {
  description = "Resource ID of the Azure Key Vault."
  type        = string
}


variable "storage_container_id" {
  description = "Resource ID of the Blob container used by the application."
  type        = string
}