
# Azure Networking Design

## 1. Overview

The platform uses an Azure Virtual Network (VNet) to provide private connectivity between the application and its supporting Azure services.

The design separates App Service outbound integration from Private Endpoint connectivity.

## 2. Virtual Network Configuration

The following address ranges are configured:

| Component                      | Address range |
| ------------------------------ | ------------- |
| Virtual Network                | 10.20.0.0/16  |
| App Service integration subnet | 10.20.1.0/24  |
| Private Endpoint subnet        | 10.20.2.0/24  |

## 3. Subnet Design

### App Service Integration Subnet

- Delegated to `Microsoft.Web/serverFarms`.
- Used for outbound connectivity from App Service into the Virtual Network.
- Associated with a Network Security Group.

### Private Endpoint Subnet

- Hosts private network interfaces for Azure services.
- Configured with private endpoint network policies disabled.
- Used by the application's supporting services for private connectivity.

These subnets serve different purposes and are not interchangeable.

## 4. Private Endpoints

The architecture provisions Private Endpoints for:

| Service            | Private Endpoint purpose                |
| ------------------ | --------------------------------------- |
| Azure App Service  | Private inbound application access      |
| Azure Key Vault    | Private access to application secrets   |
| Azure Blob Storage | Private access to application documents |
| Azure Monitor      | Private monitoring ingestion            |

Public network access is disabled for App Service, Key Vault, and Storage.

## 5. Private DNS

Private DNS Zones provide name resolution for the private endpoints.

The design includes:

- `privatelink.azurewebsites.net`
- `privatelink.vaultcore.azure.net`
- `privatelink.blob.core.windows.net`
- Azure Monitor Private Link DNS zones

The zones are linked to the platform VNet.

For users accessing the platform from outside the VNet, the organization must provide appropriate private routing and DNS forwarding.

## 6. Network Access Considerations

The current Terraform configuration does not provision:

- Employee VPN or ExpressRoute.
- VNet peering to corporate networks.
- Centralized Azure Firewall or outbound traffic inspection.
- External DNS forwarding infrastructure.

These components must be addressed separately to provide authorized employee access and meet the organization's network security requirements.

## 7. Validation

After deployment, verify:

- Private Endpoint provisioning.
- Private DNS record creation and resolution.
- Connectivity from authorized networks.
- App Service outbound connectivity to private resources.
- Public access restrictions on the supported services.

---

**End of Networking Design Document**
