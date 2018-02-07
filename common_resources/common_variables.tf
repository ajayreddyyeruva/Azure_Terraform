# All variables needed for common

variable "location" {
    description = "The location where resources will be build"
    default     = "eastus"
}

variable "resource_group" {
  description = "The resource group to which all resources will be tagged."
  default     = "az_rg"
}

variable "virtual_network" {
  description = "The virtual network in which subnets will be created."
  default     = "az_Vnet"
}

variable "external_nginx_availability_set" {
  description = "The availability_set in which external nginx VMs will reside for HA."
  default     = "external_nginx_av_set"
}

variable "app_availability_set" {
  description = "The availability_set in which app VMs will reside for HA."
  default     = "app_av_set"
}

variable "db_availability_set" {
  description = "The availability_set in which db VMs will reside for HA."
  default     = "db_av_set"
}

variable "hostname" {
  description = "VM name referenced also in storage-related names."
  default     = "az-app"
}

variable "storage_account_tier" {
  description = "Defines the Tier of storage account to be created. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Defines the Replication Type to use for this storage account. Valid options include LRS, GRS etc."
  default     = "LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_D1"
}

variable "image_publisher" {
  description = "name of the publisher of the image (az vm image list)"
  default     = "OpenLogic"
}

variable "image_offer" {
  description = "the name of the offer (az vm image list)"
  default     = "CentOS"
}

variable "image_sku" {
  description = "image sku to apply (az vm image list)"
  default     = "7.4"
}

variable "image_version" {
  description = "version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "administrator user name"
  default     = "az"
}

variable "admin_password" {
  description = "administrator password (recommended to disable password auth)"
  default = "azure@123"
}
