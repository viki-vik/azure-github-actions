variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region where AKS will be deployed"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where AKS nodes will be deployed"
}

variable "acr_id" {
  type        = string
  description = "ID of the Azure Container Registry to grant pull access"
}

variable "private_dns_zone_id" {
  type        = string
  description = "ID of the Azure Private DNS Zone for AKS API server resolution"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}
