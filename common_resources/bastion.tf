resource "azurerm_network_interface" "bastion_nic" {
  name                = "bastion_nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                                    = "bastion_ipconfig"
    subnet_id                               = "${azurerm_subnet.default.id}"
    private_ip_address_allocation           = "Dynamic"
    public_ip_address_id                    = "${azurerm_public_ip.bastion-pip.id}"
  }
}

resource "azurerm_public_ip" "bastion-pip" {
  name                         = "bastion-pip"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  public_ip_address_allocation = "Dynamic"
  idle_timeout_in_minutes      = 30
}

resource "azurerm_virtual_machine" "bastion" {
  name                  = "linux_bastion"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${azurerm_network_interface.bastion_nic.id}"]

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "bastion_disk"
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
