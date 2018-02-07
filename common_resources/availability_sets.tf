resource "azurerm_availability_set" "external_nginx" {
  name                = "${var.external_nginx_availability_set}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed = true

  tags {
    environment = "Production"
    av_set_for  = "External_Nginx"
  }
}

resource "azurerm_availability_set" "app" {
  name                = "${var.app_availability_set}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed = true

  tags {
    environment = "Production"
    av_set_for  = "app"
  }
}

resource "azurerm_availability_set" "db" {
  name                = "${var.db_availability_set}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed = true

  tags {
    environment = "Production"
    av_set_for  = "db"
  }
}
