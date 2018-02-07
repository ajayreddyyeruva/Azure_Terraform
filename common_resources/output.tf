output "loc" {
  value = "${var.location}"
}

output "res_grp" {
    value = "${var.resource_group}"
}

output "ext_nginx_av_set_id" {
    value = "${azurerm_availability_set.external_nginx.id}"
}

output "az_ext_nginx_id" {
    value = "${azurerm_subnet.az-ext-nginx.id}"
}

output "ext_nginx_av_set" {
    value = "${azurerm_availability_set.external_nginx.name}"
}

output "app_av_set_id" {
    value = "${azurerm_availability_set.app.id}"
}

output "az_app_subnet_id" {
    value = "${azurerm_subnet.az_app_private.id}"
}

output "app_av_set" {
    value = "${azurerm_availability_set.app.name}"
}

output "db_av_set_id" {
    value = "${azurerm_availability_set.db.id}"
}

output "az_db_subnet_id" {
    value = "${azurerm_subnet.az_db_private.id}"
}

output "db_av_set" {
    value = "${azurerm_availability_set.db.name}"
}
