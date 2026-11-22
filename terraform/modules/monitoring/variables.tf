
variable "workspace_name" {
  description = "Name of the Log Analytics Workspace."
  type        = string
}

variable "application_insights_name" {
  description = "Name of the Application Insights resource."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group where monitoring resources will be created."
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources."
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain Log Analytics data."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to monitoring resources."
  type        = map(string)
  default     = {}
}
