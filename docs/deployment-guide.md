
# Terraform Deployment Guide

## 1. Overview

This guide describes how to initialize, validate, plan, and deploy the Azure Internal Web Application Platform using Terraform.

The project uses a separate bootstrap configuration for remote Terraform state storage and a main configuration for platform infrastructure.

## 2. Prerequisites

Ensure the following are available:

- Terraform CLI version 1.15 or later.
- Azure CLI.
- Access to the target Azure subscription.
- Appropriate Azure resource deployment permissions.
- Required Microsoft Entra ID security group object IDs.
- Access to the remote Terraform state Storage Account.

Authenticate to Azure:

```powershell
az login
az account set --subscription "<SUBSCRIPTION_ID>"
```

## 3. Configure Terraform Variables

Navigate to the main Terraform directory:

```powershell
cd terraform
```

Create a local configuration file from the example:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

Update `terraform.tfvars` with the actual environment-specific values, including:

- Azure subscription ID.
- Key Vault name.
- Storage Account name.
- Log Analytics Workspace name.
- Application Insights name.
- Existing Entra ID security group object IDs.

Do not commit the actual `terraform.tfvars` file.

## 4. Initialize Terraform

The remote state Storage Account and container must already exist.

Initialize the main Terraform configuration:

```powershell
terraform init
```

The backend uses Azure AD authentication to access the remote state.

## 5. Format and Validate

Format the Terraform configuration:

```powershell
terraform fmt -recursive
```

Validate the configuration:

```powershell
terraform validate
```

## 6. Review the Terraform Plan

Generate an execution plan:

```powershell
terraform plan -out=tfplan.tfplan
```

Review the proposed changes carefully before approving deployment.

Pay particular attention to:

- Network configuration.
- Private Endpoints and DNS.
- Managed Identity permissions.
- Key Vault and Storage security settings.
- RBAC and PIM assignments.
- Monitoring configuration.

## 7. Apply Infrastructure

Only after the plan has been reviewed and approved:

```powershell
terraform apply tfplan.tfplan
```

## 8. Verify Deployment

Review Terraform outputs:

```powershell
terraform output
```

Verify that:

- Azure resources were created successfully.
- Public network access restrictions are configured.
- Private Endpoints are provisioned.
- Private DNS resolution works.
- Managed Identity permissions are assigned.
- Diagnostic settings are active.
- PIM and RBAC configurations match the intended governance model.

## 9. Important Notes

- The bootstrap configuration must be deployed before initializing the main remote backend if the state infrastructure does not already exist.
- The Terraform runner must have the required Azure management and data-plane permissions.
- Private connectivity and DNS must be tested from the appropriate network.
- Application deployment and application-level telemetry instrumentation are outside the Terraform infrastructure scope.
- Never commit Terraform state, plans, credentials, or actual environment-specific variable files.

---

**End of Deployment Guide**
