# Resource Group Configuration
location            = "eastus2"
resource_group_name = "rg-dev-main"

# Network Configuration
vnet_name          = "vnet-dev-main"
vnet_address_space = ["10.0.0.0/16"]
subnets = {
  "subnet-1" = "10.0.1.0/24" # Application subnet
  "subnet-2" = "10.0.2.0/24" # Database subnet
}

# Key Vault Configuration
key_vault_name    = "kv-dev-main"
allowed_ip_ranges = []

# Common Tags
tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
}

# Note: tenant_id should be provided via environment variable or secure method
# tenant_id = "your-tenant-id"

# Backend Configuration
backend_resource_group_name  = "rg-terraform-backend"
backend_storage_account_name = "tfstategp2ej81f"
backend_container_name       = "container-tfstate"
backend_key                  = "dev.terraform.tfstate"
