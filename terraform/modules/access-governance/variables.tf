
variable "resource_group_id" {
  description = "Resource ID of the application Resource Group."
  type        = string
}

variable "readers_group_object_id" {
  description = "Object ID of the COMPANYA_READERS security group."
  type        = string
}

variable "writers_group_object_id" {
  description = "Object ID of the COMPANYA_WRITERS security group."
  type        = string
}
