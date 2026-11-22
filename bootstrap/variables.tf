variable "location" {
  description = "Azure region where the Terraform state resources will be deployed."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group used for Terraform remote state."
  type        = string
  default     = "rg-companya-terraform-state-prod"
}

variable "storage_account_name" {
  description = "Globally unique Azure Storage Account name for Terraform state."
  type        = string
}

variable "container_name" {
  description = "Blob container used to store Terraform state."
  type        = string
  default     = "tfstate"
}