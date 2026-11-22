
# Azure Internal Web Application Platform — Architecture

## 1. Overview

This project provisions the foundational Azure infrastructure for an internal-facing .NET 10 web application using Terraform.

The architecture focuses on private connectivity, centralized identity management, secure data access, monitoring, and controlled administrative access.

## 2. Infrastructure Components

| Component                      | Purpose                                         |
| ------------------------------ | ----------------------------------------------- |
| Azure Resource Group           | Organizes platform resources                    |
| Virtual Network                | Provides private network connectivity           |
| Linux App Service              | Hosts the .NET 10 application                   |
| User-Assigned Managed Identity | Enables passwordless application authentication |
| Azure Key Vault                | Stores application secrets                      |
| Azure Blob Storage             | Stores application documents                    |
| Log Analytics                  | Centralizes platform logs                       |
| Application Insights           | Supports application monitoring                 |
| Azure Monitor Private Link     | Provides private monitoring ingestion           |
| Azure RBAC and PIM             | Controls application and administrative access  |

## 3. Network Design

The platform uses a Virtual Network with the following address ranges:

| Network                        | Address range |
| ------------------------------ | ------------- |
| VNet                           | 10.20.0.0/16  |
| App Service integration subnet | 10.20.1.0/24  |
| Private Endpoint subnet        | 10.20.2.0/24  |

Private Endpoints are configured for App Service, Key Vault, Blob Storage, and Azure Monitor.

Private DNS Zones provide name resolution for these services within the Virtual Network.

App Service VNet Integration supports outbound connectivity to private resources. Employee access from outside the VNet requires additional connectivity, such as VPN, ExpressRoute, or VNet peering.

## 4. Identity and Security

One shared User-Assigned Managed Identity is assigned to the App Service.

Azure RBAC grants this identity:

- Key Vault Secrets User — to retrieve authorized application secrets.
- Storage Blob Data Contributor — to access application documents.

Administrative access is managed through existing Entra ID security groups:

- `COMPANYA_READERS` — Reader access.
- `COMPANYA_WRITERS` — PIM-eligible Contributor access.

The configured Contributor activation policy requires MFA and justification, with a maximum activation duration of four hours.

Key Vault, Storage, and App Service are configured with public network access disabled.

## 5. Monitoring

Log Analytics Workspace and Application Insights provide centralized monitoring.

Terraform configures diagnostic settings for App Service, Key Vault, and Blob Storage.

Azure Monitor Private Link Scope connects the monitoring resources to private monitoring ingestion. Query access remains configured as Open.

Application-level telemetry requires additional instrumentation in the .NET application.

## 6. Terraform Structure

The infrastructure is organized into reusable modules covering:

- Resource Group and networking
- Private DNS
- Managed Identity
- App Service
- Key Vault and Storage
- Monitoring and diagnostics
- RBAC and access governance
- Azure Monitor Private Link

A separate bootstrap configuration provisions the remote Terraform state infrastructure.

## 7. Scope and Limitations

This assessment provisions infrastructure only. It does not include:

- .NET application deployment
- Azure DevOps CI/CD pipeline
- Employee VPN or ExpressRoute
- External DNS forwarding
- Automated backup and disaster recovery implementation

The Terraform configuration has been structurally validated. Successful validation does not guarantee successful Azure deployment; permissions, service availability, networking, and tenant configuration must also be verified.

---

**End of Architecture Document**
