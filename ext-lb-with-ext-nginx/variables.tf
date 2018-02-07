variable "location" {}

variable "resource_group" {}

variable "external_nginx_availability_set" {}

variable "ext_nginx_subnet_id" {}

variable "external_nginx_availability_set_id" {}

variable "hostname" {
  description = "VM name referenced also in storage-related names."
  default     = "az-external-nginx"
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

variable "vm_count" {
description = "Enter the number of NGINX VMs"
default     = 2
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
