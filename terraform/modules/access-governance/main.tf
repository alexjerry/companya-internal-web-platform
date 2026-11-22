
# Retrieve the built-in Contributor role definition
# at the application Resource Group scope.

data "azurerm_role_definition" "contributor" {
  name  = "Contributor"
  scope = var.resource_group_id
}

# COMPANYA_READERS:
# Permanent, active Reader access at Resource Group scope.

resource "azurerm_role_assignment" "readers" {
  scope                = var.resource_group_id
  role_definition_name = "Reader"
  principal_id         = var.readers_group_object_id
  principal_type       = "Group"
}

# COMPANYA_WRITERS:
# Eligible Contributor assignment through PIM.

resource "azurerm_pim_eligible_role_assignment" "writers" {
  scope              = var.resource_group_id
  role_definition_id = data.azurerm_role_definition.contributor.id
  principal_id       = var.writers_group_object_id

  justification = "COMPANYA_WRITERS time-bound eligible Contributor access"

  schedule {
    expiration {
      duration_days = 365
    }
  }
}

# Configure the Contributor PIM policy at Resource Group scope.

resource "azurerm_role_management_policy" "contributor" {
  scope              = var.resource_group_id
  role_definition_id = data.azurerm_role_definition.contributor.id

  # Eligible assignments expire after 365 days.
  eligible_assignment_rules {
    expire_after = "P365D"
  }

  # Configure just-in-time activation controls.
  activation_rules {
    maximum_duration                   = "PT4H"
    require_approval                   = false
    require_justification              = true
    require_multifactor_authentication = true
  }
}
