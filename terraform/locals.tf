
locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    var.tags,
    {
      environment = var.environment
      managed_by  = "terraform"
      project     = var.project_name
    }
  )

  resource_names = {
    virtual_network         = "vnet-${local.name_prefix}"
    app_service             = "app-${local.name_prefix}"
    managed_identity        = "id-${local.name_prefix}"
    app_subnet              = "snet-${local.name_prefix}-app"
    private_endpoint_subnet = "snet-${local.name_prefix}-private-endpoints"
    network_security_group  = "nsg-${local.name_prefix}-app"
    app_service_plan        = "asp-${local.name_prefix}"
  }
}
