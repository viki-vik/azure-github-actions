resource "azurerm_container_registry" "acr" {
  name                = "dev-acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}
