
# Architecture Assumptions and Design Decisions

## 1. General Assumptions

- The solution is deployed in a single Azure subscription and Resource Group.
- East US is used as the default Azure deployment region.
- The environment is configured for production (`prod`).
- Existing Microsoft Entra ID security groups are available for administrative access.
- The organization manages employee connectivity to the Azure Virtual Network separately.

## 2. Networking

- The Virtual Network uses `10.20.0.0/16`.
- Separate subnets are used for App Service VNet Integration and Private Endpoints.
- Private DNS Zones are used for Azure service name resolution.
- Employee access from external networks requires existing VPN, ExpressRoute, or VNet peering connectivity.
- Network egress filtering and centralized firewall infrastructure are outside this assessment's scope.

## 3. Identity and Access

- One User-Assigned Managed Identity is shared by the application for supported Azure resource authentication.
- The identity receives only the permissions required to access Key Vault secrets and Blob Storage.
- Existing Entra ID security groups are used for Reader and Contributor access.
- Contributor access is managed through Privileged Identity Management (PIM), subject to licensing and tenant configuration.

## 4. Application and Data Services

- Azure App Service on Linux hosts the .NET 10 application.
- The application code is developed and deployed separately.
- Key Vault stores application secrets.
- Azure Blob Storage stores application documents.
- The application uses Managed Identity rather than embedded credentials or storage account keys.
- Application-level telemetry requires instrumentation within the application code.

## 5. Monitoring and Operations

- Log Analytics Workspace is the centralized destination for supported platform diagnostics.
- Application Insights provides application monitoring capabilities.
- Azure Monitor Private Link is configured for private monitoring ingestion.
- Monitoring query access remains configured as Open.
- Automated backup, disaster recovery, and business continuity processes require additional implementation.

## 6. Terraform and State Management

- Terraform is the selected Infrastructure as Code tool.
- Infrastructure is organized into reusable modules.
- Azure Storage is used for remote Terraform state.
- The bootstrap configuration is responsible for provisioning the remote state infrastructure.
- The main Terraform configuration uses Azure AD authentication to access the remote backend.
- Actual resource deployment requires appropriate Azure permissions and successful infrastructure planning.

## 7. Out of Scope

The following are not included in this assessment:

- Azure DevOps CI/CD pipeline.
- Application source code and deployment.
- Employee VPN or ExpressRoute provisioning.
- External DNS forwarding configuration.
- Centralized firewall and outbound traffic inspection.
- Automated backup and disaster recovery orchestration.

---

**End of Assumptions Document**
