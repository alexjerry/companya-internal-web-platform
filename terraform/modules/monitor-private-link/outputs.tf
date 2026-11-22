
output "ampls_id" {
  description = "Resource ID of the Azure Monitor Private Link Scope."
  value       = azurerm_monitor_private_link_scope.this.id
}

output "ampls_name" {
  description = "Name of the Azure Monitor Private Link Scope."
  value       = azurerm_monitor_private_link_scope.this.name
}

output "private_endpoint_id" {
  description = "Resource ID of the Azure Monitor Private Endpoint."
  value       = azurerm_private_endpoint.this.id
}

output "private_endpoint_private_ip" {
  description = "Private IP address assigned to the Azure Monitor Private Endpoint."
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}

output "private_dns_zone_ids" {
  description = "IDs of the five Azure Monitor-related private DNS zones."
  value = [
    azurerm_private_dns_zone.monitor.id,
    azurerm_private_dns_zone.oms.id,
    azurerm_private_dns_zone.ods.id,
    azurerm_private_dns_zone.agentsvc.id,
    var.storage_blob_private_dns_zone_id
  ]
}
