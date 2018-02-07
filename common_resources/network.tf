resource "azurerm_virtual_network" "az_Vnet" {
  name                = "${var.virtual_network}"
  address_space       = ["10.1.0.0/20"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.az_rg.name}"
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${var.virtual_network}"
  address_prefix       = "10.1.0.0/26"
}

resource "azurerm_subnet" "az-ext-nginx" {
  name                 = "az-ext-nginx"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${var.virtual_network}"
  address_prefix       = "10.1.1.0/24"
  network_security_group_id = "${azurerm_network_security_group.nsg_external_lb.id}"
}

resource "azurerm_subnet" "az_app_private" {
  name                 = "az-app_private"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${var.virtual_network}"
  address_prefix       = "10.1.2.0/24"
}

resource "azurerm_subnet" "az_db_private" {
  name                 = "az_db_private"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = "${var.virtual_network}"
  address_prefix       = "10.1.6.0/24"
}
