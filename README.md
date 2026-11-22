
# Enterprise Internal-Facing Web Application Platform

## 1. Project Overview

This project provisions the foundational Azure infrastructure for an enterprise internal-facing web application using **Terraform** and the AzureRM provider.

The platform is designed to host a .NET 10 application on Azure Linux App Service, securely store application secrets in Azure Key Vault, and store documents in Azure Blob Storage.

The architecture emphasizes private connectivity, centralized monitoring, managed identity authentication, and role-based access control.

### Key Objectives

- Deploy an Azure Linux App Service Plan and Web App.
- Use Azure Key Vault for centralized secrets management.
- Use Azure Blob Storage for document storage.
- Establish private endpoints for application and data services.
- Use Azure Private DNS for private name resolution.
- Implement a shared User-Assigned Managed Identity.
- Configure Azure RBAC for application access to Key Vault and Storage.
- Centralize platform diagnostics and application monitoring.
- Integrate Azure Monitor Private Link Scope.
- Implement existing Entra security group access and PIM-eligible Contributor governance.

## 2. Architecture Components

| Component                        | Purpose                                                      |
| -------------------------------- | ------------------------------------------------------------ |
| Azure Resource Group             | Organizes platform resources                                 |
| Virtual Network                  | Provides the private network foundation                      |
| App Service Integration Subnet   | Enables outbound connectivity from App Service into the VNet |
| Private Endpoint Subnet          | Hosts private endpoints                                      |
| Network Security Group           | Provides subnet-level network traffic filtering              |
| Azure Linux App Service          | Hosts the .NET 10 application                                |
| Azure Key Vault                  | Stores application secrets                                   |
| Azure Blob Storage               | Stores application documents                                 |
| User-Assigned Managed Identity   | Provides shared workload identity                            |
| Azure RBAC                       | Grants the managed identity access to required resources     |
| Azure Private DNS                | Resolves private service endpoints                           |
| Log Analytics Workspace          | Centralizes platform logs                                    |
| Application Insights             | Provides application telemetry                               |
| Azure Monitor Private Link Scope | Supports private monitoring ingestion                        |
| Diagnostic Settings              | Routes supported resource logs and metrics to Log Analytics  |
| Entra Security Groups and PIM    | Govern administrative access                                 |

## 3. Network Architecture

The virtual network uses the following address space:

- VNet: `10.20.0.0/16`
- App Service integration subnet: `10.20.1.0/24`
- Private Endpoint subnet: `10.20.2.0/24`

The application uses VNet integration for outbound connectivity to private resources.

Private endpoints provide private access to:

- Azure App Service
- Azure Key Vault
- Azure Blob Storage
- Azure Monitor

Private DNS zones provide name resolution for the private endpoints.

The application and data services have public network access disabled in their respective Terraform configurations.

**Network connectivity assumption:** Employee devices and authorized administrators must have an approved private network path into the VNet, such as VPN, ExpressRoute, or VNet peering. This connectivity is not provisioned by the current Terraform configuration.

## 4. Identity and Access Management

The platform creates one shared User-Assigned Managed Identity.

The identity is assigned the following permissions:

| Resource     | Azure Role                    | Scope               |
| ------------ | ----------------------------- | ------------------- |
| Key Vault    | Key Vault Secrets User        | Key Vault           |
| Blob Storage | Storage Blob Data Contributor | Documents container |

Managed identity authentication avoids embedding application credentials or storage account keys in application configuration.

### Administrative Access

The platform uses existing Entra security groups:

- `COMPANYA_READERS`: Reader access at Resource Group scope.
- `COMPANYA_WRITERS`: PIM-eligible Contributor access at Resource Group scope.

The Contributor role management policy configures activation requirements, including MFA, justification, and a maximum activation duration.

The PIM configuration is subject to appropriate licensing, permissions, and tenant governance settings. The Contributor role management policy applies at the configured Resource Group scope.

## 5. Monitoring and Diagnostics

The platform provisions:

- Azure Log Analytics Workspace.
- Azure Application Insights.
- Azure Monitor Private Link Scope.
- Diagnostic settings for supported platform resources.

Diagnostic settings route supported platform logs and metrics to Log Analytics.

Application Insights connection information is configured in the Web App settings. The application must additionally implement Application Insights SDK or Azure Monitor OpenTelemetry instrumentation to generate application telemetry.

The Azure Monitor Private Link configuration restricts ingestion through its configured private access mode. Query access is currently configured as `Open`; therefore, this design does not claim that all monitoring query traffic is private.

## 6. Repository Structure

```text
companya-internal-web-platform/
│
├── README.md
├── ASSUMPTIONS.md
├── ARCHITECTURE.md
├── .gitignore
├── .terraform.lock.hcl
│
├── bootstrap/
│
└── terraform/
    ├── main.tf
    ├── providers.tf
    ├── versions.tf
    ├── variables.tf
    ├── locals.tf
    ├── outputs.tf
    ├── data.tf
    ├── backend.tf
    ├── terraform.tfvars.example
    │
    └── modules/
        ├── resource-group/
        ├── networking/
        ├── private-dns/
        ├── managed-identity/
        ├── app-service/
        ├── key-vault/
        ├── storage/
        ├── rbac/
        ├── monitoring/
        ├── diagnostics/
        ├── access-governance/
        └── monitor-private-link/
```

Each module separates its inputs, resources, and outputs using:

- `variables.tf`
- `main.tf`
- `outputs.tf`

## 7. Prerequisites

Before deployment, ensure the following are available:

- An Azure subscription.
- Terraform CLI version `1.15.0` or later, below `2.0.0`.
- Azure CLI.
- An authenticated Azure account.
- AzureRM Terraform provider version `~> 4.0`.
- Appropriate Azure permissions to create resources and role assignments.
- Appropriate permissions and licensing for PIM configuration.
- Existing Entra security groups and their object IDs.
- Globally unique Key Vault and Storage Account names.
- Private network connectivity for resources requiring private data-plane access.

The Terraform deployment identity must have the necessary permissions to create Azure resources, role assignments, and PIM-related configurations.

## 8. Configuration

Navigate to the Terraform directory:

```powershell
cd terraform
```

Create a local variables file from the example:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and provide the actual deployment values:

- Azure subscription ID.
- Globally unique Key Vault name.
- Globally unique Storage Account name.
- Log Analytics Workspace name.
- Application Insights name.
- Existing COMPANYA_READERS group object ID.
- Existing COMPANYA_WRITERS group object ID.

Do not commit the actual `terraform.tfvars` file to GitHub.

## 9. Terraform Validation

Format the Terraform configuration:

```powershell
terraform fmt -recursive
```

Initialize the configuration without configuring the remote backend:

```powershell
terraform init -backend=false
```

Validate the configuration:

```powershell
terraform validate
```

These commands check formatting, provider and module initialization, and Terraform configuration validity. They do not confirm that Azure resources can successfully be deployed.

## 10. Terraform Deployment

The project includes an Azure Storage remote backend configuration in `backend.tf`.

The remote backend must be initialized before deployment. The backend Storage Account and container must already exist, and the deployment identity must have the required data-plane permissions.

After reviewing the backend configuration and confirming the deployment prerequisites:

Initialize Terraform with the configured remote backend:

```powershell
terraform init
```

Review the proposed deployment:

```powershell
terraform plan -out=tfplan
```

Inspect the plan carefully before applying.

Deploy only after the plan has been reviewed and explicitly approved:

```powershell
terraform apply tfplan
```

Retrieve deployment outputs:

```powershell
terraform output
```

**Important:** `terraform apply` creates or modifies Azure resources. Do not run it without reviewing and approving the proposed changes.

## 11. Security Considerations

- Public network access is disabled for the Web App, Key Vault, and Storage Account.
- Private endpoints provide private connectivity to supported services.
- Azure Private DNS supports private endpoint name resolution.
- Managed identity is used for workload authentication.
- Storage shared key access is disabled.
- Blob container access is private.
- Key Vault soft delete and purge protection are enabled.
- HTTPS is enforced for the Web App and Storage Account.
- Minimum TLS version is configured.
- Sensitive Terraform variables and state files must not be committed to source control.
- Remote Terraform state must be protected through appropriate Azure RBAC and storage security controls.

## 12. Scope and Limitations

This project provisions infrastructure and its associated identity, networking, access, and monitoring configuration.

The following are outside the current Terraform deployment scope:

- Deployment of the actual .NET application code.
- Application-level SDK or OpenTelemetry instrumentation.
- Provisioning employee VPN or ExpressRoute connectivity.
- Creating or modifying existing Entra security groups.
- Establishing custom firewall, NAT Gateway, or Azure Firewall infrastructure.
- Configuring custom DNS forwarders for external DNS infrastructure.
- Configuring application-specific secret values.

Additional application and network configuration may be required before the platform is ready for production workloads.

## 13. Validation Evidence

The Terraform configuration has been formatted and validated using:

```powershell
terraform fmt -recursive
terraform init -backend=false
terraform validate
```

Terraform validation has completed successfully.

Validation success confirms that the Terraform configuration is structurally valid. It does not establish that resources have been deployed or that all Azure permissions, regional availability, quotas, naming constraints, and private connectivity requirements have been satisfied.

## 14. Technology Stack

- Microsoft Azure
- Terraform
- AzureRM Provider
- Azure Linux App Service
- .NET 10
- Azure Virtual Network
- Azure Private Link
- Azure Private DNS
- Azure Key Vault
- Azure Blob Storage
- Microsoft Entra ID
- Azure RBAC
- Privileged Identity Management
- Azure Monitor
- Log Analytics
- Application Insights
