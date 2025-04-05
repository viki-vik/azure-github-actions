output "acr_name" {
  value = module.acr.acr_name
}

output "aks_kube_config" {
  value     = module.aks.kube_config
  sensitive = true
}
