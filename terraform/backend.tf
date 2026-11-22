
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-companya-terraform-state-prod"
    storage_account_name = "tfstatecompanya2026"
    container_name       = "tfstate"
    key                  = "companya-platform-prod.tfstate"

    use_azuread_auth = true
  }
}
