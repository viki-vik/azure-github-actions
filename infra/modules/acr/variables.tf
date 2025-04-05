variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group to deploy ACR in"
}

variable "location" {
  type        = string
  description = "Azure region where ACR will be deployed"
}
