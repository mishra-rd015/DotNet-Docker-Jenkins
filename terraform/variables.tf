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
