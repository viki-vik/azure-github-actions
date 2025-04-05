variable "location" {
  type        = string
  description = "Azure region where all resources will be deployed"
  default     = "eastus"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
  default     = "myPrivateAKS"
}
