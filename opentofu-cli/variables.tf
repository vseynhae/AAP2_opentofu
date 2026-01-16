variable "location" {
  description = "The Azure region to deploy resources into"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-opentofu-demo"
}

variable "vm_size" {
  description = "The SKU of the Virtual Machine"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Username for the Virtual Machine"
  type        = string
  default     = "azureuser"
}
