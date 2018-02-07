resource "azurerm_network_interface" "app_nic" {
  name                = "app_nic_0${count.index}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  count               = "${var.vm_count}"

  ip_configuration {
    name                                    = "app_ipconfig${count.index}"
    subnet_id                               = "${var.app_subnet_id}"
    private_ip_address_allocation           = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "az_app" {
  name                  = "app_0${count.index}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  availability_set_id   = "${var.app_availability_set_id}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${element(azurerm_network_interface.app_nic.*.id, count.index)}"]
  count                 = "${var.vm_count}"

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "app_osdisk_0${count.index}"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
  disable_password_authentication = false
 }
}
