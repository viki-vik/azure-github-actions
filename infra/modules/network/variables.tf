variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region where the virtual network will be deployed"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR block for the virtual network"
  default     = "10.0.0.0/8"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the AKS subnet"
  default     = "10.240.0.0/16"
}
