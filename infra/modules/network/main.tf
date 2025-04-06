resource "azurerm_virtual_network" "vnet" {
  name                = "nextjs-dev-aks-vnet"
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "nextjs-dev-aks-subnet"
  address_prefixes     = [var.subnet_cidr]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
