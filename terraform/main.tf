
module "resource_group" {
  source = "./modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "networking" {
  source = "./modules/networking"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  vnet_name          = local.resource_names.virtual_network
  vnet_address_space = var.vnet_address_space

  app_subnet_name             = local.resource_names.app_subnet
  app_subnet_address_prefixes = var.app_subnet_address_prefixes

  private_endpoint_subnet_name             = local.resource_names.private_endpoint_subnet
  private_endpoint_subnet_address_prefixes = var.private_endpoint_subnet_address_prefixes

  nsg_name = local.resource_names.network_security_group

  tags = local.common_tags

}

module "private_dns" {
  source = "./modules/private-dns"

  resource_group_name = module.resource_group.resource_group_name
  virtual_network_id  = module.networking.vnet_id

  tags = local.common_tags
}

module "managed_identity" {
  source = "./modules/managed-identity"

  name                = local.resource_names.managed_identity
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  tags = local.common_tags
}


module "app_service" {
  source = "./modules/app-service"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  app_service_plan_name = local.resource_names.app_service_plan
  app_name              = local.resource_names.app_service
  app_service_plan_sku  = var.app_service_plan_sku

  integration_subnet_id = module.networking.app_subnet_id

  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id

  managed_identity_id = module.managed_identity.id

  web_app_private_dns_zone_id = module.private_dns.web_app_private_dns_zone_id

  tags = local.common_tags

  key_vault_uri = module.key_vault.key_vault_uri

  storage_blob_endpoint = module.storage.primary_blob_endpoint

  managed_identity_client_id             = module.managed_identity.client_id
  application_insights_connection_string = module.monitoring.application_insights_connection_string

}


module "key_vault" {
  source = "./modules/key-vault"

  name                = var.key_vault_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  tenant_id = data.azurerm_client_config.current.tenant_id

  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id

  private_dns_zone_id = module.private_dns.key_vault_private_dns_zone_id

  tags = local.common_tags
}


module "storage" {
  source = "./modules/storage"

  storage_account_name = var.storage_account_name

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id

  private_dns_zone_id = module.private_dns.storage_blob_private_dns_zone_id

  tags = local.common_tags
}


module "rbac" {
  source = "./modules/rbac"

  managed_identity_principal_id = module.managed_identity.principal_id
  key_vault_id                  = module.key_vault.key_vault_id
  storage_container_id          = module.storage.container_id
}

module "monitoring" {
  source = "./modules/monitoring"

  workspace_name = var.log_analytics_workspace_name

  application_insights_name = var.application_insights_name

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location

  retention_in_days = var.log_analytics_retention_days

  tags = local.common_tags
}

module "monitor_private_link" {
  source = "./modules/monitor-private-link"

  name                = "ampls-${local.name_prefix}"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  virtual_network_id         = module.networking.vnet_id
  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  application_insights_id    = module.monitoring.application_insights_id

  storage_blob_private_dns_zone_id = module.private_dns.storage_blob_private_dns_zone_id

  tags = local.common_tags
}


module "diagnostics" {
  source = "./modules/diagnostics"

  key_vault_id = module.key_vault.key_vault_id

  web_app_id = module.app_service.web_app_id

  storage_account_id = module.storage.storage_account_id

  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
}


module "access_governance" {
  source = "./modules/access-governance"

  resource_group_id = module.resource_group.resource_group_id

  readers_group_object_id = var.company_readers_group_object_id
  writers_group_object_id = var.company_writers_group_object_id
}
