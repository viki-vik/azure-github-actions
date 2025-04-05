variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region to use for DNS zone naming"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster for DNS zone linkage (used for naming consistency)"
}
