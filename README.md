# Azure Terraform Infrastructure

This repository contains Terraform configurations for Azure infrastructure deployment using GitHub Actions and OpenID Connect authentication.

## Project Structure

```
├── modules/                    # Reusable Terraform modules
├── environments/              # Environment-specific configurations
│   ├── dev/
│   ├── staging/
│   └── prod/
├── .github/workflows/         # GitHub Actions workflow definitions
└── backend/                   # Backend configuration for Terraform state
```

## Prerequisites

- Azure Subscription
- GitHub repository with configured secrets
- Azure Storage Account for Terraform state

## Authentication

This project uses OpenID Connect (OIDC) for authentication between GitHub Actions and Azure, eliminating the need for storing long-lived credentials.

## Required GitHub Secrets

- `AZURE_CLIENT_ID`: Azure AD Application Client ID
- `AZURE_SUBSCRIPTION_ID`: Azure Subscription ID
- `AZURE_TENANT_ID`: Azure AD Tenant ID

## Usage

The infrastructure is deployed automatically through GitHub Actions workflows:
- On pull request: `terraform plan` is executed
- On merge to main: `terraform apply` is executed

## Best Practices

- Use of remote state in Azure Storage Account
- State locking implemented
- Modular design for reusability
- Automated formatting and validation
- Security-first approach with OIDC 