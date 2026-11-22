
output "readers_role_assignment_id" {
  description = "ID of the standing Reader assignment."
  value       = azurerm_role_assignment.readers.id
}

output "writers_eligible_assignment_id" {
  description = "ID of the PIM eligible Contributor assignment."
  value       = azurerm_pim_eligible_role_assignment.writers.id
}

output "contributor_pim_policy_id" {
  description = "ID of the Contributor PIM role management policy."
  value       = azurerm_role_management_policy.contributor.id
}
