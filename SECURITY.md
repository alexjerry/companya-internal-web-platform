
# Security Design

## 1. Overview

The platform follows a security-focused design using private network connectivity, managed identities, Azure RBAC, centralized secrets management, and privileged access governance.

## 2. Network Security

- App Service, Key Vault, and Storage have public network access disabled.
- Private Endpoints provide private connectivity to supported Azure services.
- Private DNS Zones provide private name resolution.
- App Service VNet Integration supports outbound access to private resources.
- HTTPS is enforced for the web application.
- Minimum TLS version is configured as 1.2.
- FTPS is disabled.

## 3. Identity and Access Management

- A shared User-Assigned Managed Identity is assigned to the App Service.
- The application uses Managed Identity for supported Azure service authentication.
- Key Vault Secrets User permissions allow authorized secret retrieval.
- Storage Blob Data Contributor permissions allow access to application documents.
- Existing Entra ID security groups manage administrative access.
- Reader access is assigned to `COMPANYA_READERS`.
- Contributor access for `COMPANYA_WRITERS` is PIM-eligible rather than permanently active.

## 4. Secrets and Data Protection

### Azure Key Vault

- Azure RBAC authorization is enabled.
- Public network access is disabled.
- Private Endpoint connectivity is configured.
- Soft-delete retention is configured for 90 days.
- Purge protection is enabled.

### Azure Storage

- Shared key authorization is disabled.
- Public blob access is disabled.
- HTTPS-only traffic is enforced.
- TLS 1.2 is required.
- The documents container is private.
- Access is controlled through Azure RBAC.

## 5. Privileged Access Governance

The PIM configuration for Contributor access includes:

- Multi-factor authentication.
- Activation justification.
- Maximum activation duration of four hours.
- Eligible assignment expiration after 365 days.

Actual enforcement depends on Microsoft Entra ID licensing, permissions, and tenant configuration.

## 6. Monitoring and Auditing

- Diagnostic settings send supported resource logs and metrics to Log Analytics.
- Application Insights supports application monitoring.
- Azure Monitor Private Link is configured for private ingestion.
- Application-level telemetry requires additional application instrumentation.

## 7. Additional Security Considerations

The following should be addressed before production deployment:

- Verify private connectivity and DNS resolution from authorized client networks.
- Validate Azure RBAC assignments and managed identity access.
- Confirm PIM policies and activation requirements.
- Review outbound network traffic requirements and firewall controls.
- Implement backup, recovery, and retention policies.
- Perform security testing and validate that public access is blocked as intended.

---

**End of Security Design Document**
