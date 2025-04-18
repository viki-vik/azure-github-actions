provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "nextjs-dev-aks-private-rg"
  location = local.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  vnet_cidr           = "10.0.0.0/8"
  subnet_cidr         = "10.240.0.0/16"
}

module "dns" {
  source              = "./modules/dns"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  cluster_name        = local.cluster_name
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = local.location
  subnet_id           = module.network.subnet_id
  acr_id              = module.acr.acr_id
  private_dns_zone_id = module.dns.dns_zone_id
  cluster_name        = local.cluster_name
}
