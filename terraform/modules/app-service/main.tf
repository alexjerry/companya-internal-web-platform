
resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location

  os_type  = "Linux"
  sku_name = var.app_service_plan_sku

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  # Require HTTPS and disable public internet access.
  https_only                    = true
  public_network_access_enabled = false

  # Outbound private connectivity to Key Vault and Storage.
  virtual_network_subnet_id = var.integration_subnet_id

  # Attach the existing User-Assigned Managed Identity.
  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  # Use the same identity when resolving Key Vault references.
  key_vault_reference_identity_id = var.managed_identity_id

  # Non-secret application configuration.
  app_settings = {
    "AZURE_CLIENT_ID"                       = var.managed_identity_client_id
    "KeyVault__VaultUri"                    = var.key_vault_uri
    "Storage__BlobServiceUri"               = var.storage_blob_endpoint
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.application_insights_connection_string
  }

  site_config {
    always_on           = true
    ftps_state          = "Disabled"
    http2_enabled       = true
    minimum_tls_version = "1.2"

    # Configure the Linux App Service runtime for .NET 10.
    application_stack {
      dotnet_version = "10.0"
    }
  }

  tags = var.tags
}

# Private Endpoint for inbound application access.
resource "azurerm_private_endpoint" "web_app" {
  name                = "pe-${var.app_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-${var.app_name}"
    private_connection_resource_id = azurerm_linux_web_app.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.web_app_private_dns_zone_id]
  }

  tags = var.tags
}
