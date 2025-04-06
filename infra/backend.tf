terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate-nextjs-dev"
    container_name       = "tfstate"
    key                  = "aks-infra.terraform.tfstate"
    encrypt              = true
  }
}
