
data "azurerm_monitor_diagnostic_categories" "key_vault" {
  resource_id = var.key_vault_id
}

data "azurerm_monitor_diagnostic_categories" "web_app" {
  resource_id = var.web_app_id
}

data "azurerm_monitor_diagnostic_categories" "storage_blob" {
  resource_id = "${var.storage_account_id}/blobServices/default"
}

resource "azurerm_monitor_diagnostic_setting" "key_vault" {
  name                       = "diag-key-vault"
  target_resource_id         = var.key_vault_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.key_vault.log_category_types

    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.key_vault.metrics

    content {
      category = enabled_metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "web_app" {
  name                       = "diag-web-app"
  target_resource_id         = var.web_app_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.web_app.log_category_types

    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.web_app.metrics

    content {
      category = enabled_metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_blob" {
  name                       = "diag-storage-blob"
  target_resource_id         = "${var.storage_account_id}/blobServices/default"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.storage_blob.log_category_types

    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.storage_blob.metrics

    content {
      category = enabled_metric.value
    }
  }
}
