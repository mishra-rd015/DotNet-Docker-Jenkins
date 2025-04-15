variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "The Client ID of the Azure Service Principal"
  type        = string
}

variable "client_secret" {
  description = "The Client Secret of the Azure Service Principal"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Tenant ID of the Azure Active Directory"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry name (must be globally unique)"
  default     = "dotnetacr-rudram123"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "dotnet-rg"
}

variable "location" {
  description = "Azure region"
  default     = "East US"
}

variable "aks_name" {
  description = "Azure Kubernetes Service name"
  default     = "dotnet-aks"
}
