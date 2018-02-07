resource "azurerm_resource_group" "az_rg" {
  name     = "${var.resource_group}"
  location = "${var.location}"

  tags {
    environment = "Production"
    }
}
