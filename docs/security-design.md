
# Azure Security Design

## 1. Overview

The platform uses Azure security controls to protect application access, secrets, documents, and infrastructure administration.

## 2. Network Security

- Public network access is disabled for App Service, Key Vault, and Storage.
- Private Endpoints provide private connectivity to supported services.
- Private DNS Zones support private name resolution.
- App Service uses VNet integration for outbound access to private resources.
- HTTPS is enforced, and FTPS is disabled.

## 3. Identity and Access Management

A shared User-Assigned Managed Identity (UAMI) is assigned to App Service.

Its permissions include:

| Role                          | Scope               | Purpose                      |
| ----------------------------- | ------------------- | ---------------------------- |
| Key Vault Secrets User        | Key Vault           | Read application secrets     |
| Storage Blob Data Contributor | Documents container | Access application documents |

No application credentials need to be embedded in Terraform configuration.

## 4. Administrative Governance

Two existing security groups are used:

- `COMPANYA_READERS`: Reader access at the resource group scope.
- `COMPANYA_WRITERS`: PIM-eligible Contributor access at the resource group scope.

PIM activation requires MFA and justification, with a maximum activation duration of four hours.

PIM configuration depends on appropriate tenant licensing and permissions.

## 5. Data Protection

### Key Vault

- RBAC authorization.
- Private Endpoint connectivity.
- 90-day soft-delete retention.
- Purge protection enabled.

### Storage

- Public blob access disabled.
- Shared key authorization disabled.
- HTTPS and TLS 1.2 enforced.
- Private Endpoint connectivity.

## 6. Monitoring and Auditing

Diagnostic settings send supported platform logs and metrics to Log Analytics.

Application Insights provides application monitoring, while Azure Monitor Private Link supports private monitoring ingestion.

Application-level telemetry requires instrumentation in the application itself.

## 7. Additional Security Considerations

Before production deployment, verify:

- Private DNS resolution and network connectivity.
- Managed identity permissions.
- PIM activation and role assignments.
- Application outbound traffic requirements.
- Backup, recovery, and security monitoring requirements.

Centralized firewall controls and outbound traffic inspection are outside the current Terraform scope.

---

**End of Security Design Document**
