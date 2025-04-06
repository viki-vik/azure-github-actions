variable "location" {
  type        = string
  description = "Azure region where all resources will be deployed"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}
# Pass via GitHub Actions secret: AZURE_CREDENTIALS
variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID used to authenticate the provider"
}

variable "tenant_id" {
  type        = string
  description = "Azure Active Directory Tenant ID"
}

variable "client_id" {
  type        = string
  description = "Azure Service Principal Application (Client) ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Service Principal Client Secret used to authenticate"
  sensitive   = true
}

