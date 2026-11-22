
output "app_service_plan_id" {
  description = "Resource ID of the App Service Plan."
  value       = azurerm_service_plan.this.id
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan."
  value       = azurerm_service_plan.this.name
}

output "web_app_id" {
  description = "Resource ID of the Linux Web App."
  value       = azurerm_linux_web_app.this.id
}

output "web_app_name" {
  description = "Name of the Linux Web App."
  value       = azurerm_linux_web_app.this.name
}

output "web_app_default_hostname" {
  description = "Default hostname of the Linux Web App."
  value       = azurerm_linux_web_app.this.default_hostname
}

output "private_endpoint_id" {
  description = "Resource ID of the App Service Private Endpoint."
  value       = azurerm_private_endpoint.web_app.id
}

output "private_endpoint_private_ip" {
  description = "Private IP address assigned to the App Service Private Endpoint."
  value       = azurerm_private_endpoint.web_app.private_service_connection[0].private_ip_address
}
