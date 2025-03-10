location                    = "eastus2"
environment                 = "Management"
resource_group_name         = "rg-terraform-backend"
storage_account_tier        = "Standard"
storage_account_replication = "GRS"
container_name              = "container-tfstate"

tags = {
  Environment = "Management"
  Purpose     = "Terraform State"
} 