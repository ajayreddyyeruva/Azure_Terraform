resource "azurerm_storage_account" "storage" {
  name                     = "nasfilerstor"
  location                 = "${var.location}"
  resource_group_name      = "${var.resource_group}"
  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.storage_replication_type}"
}

resource "azurerm_public_ip" "external_lb_pip" {
  name                         = "az_external_lb_pip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group}"
  public_ip_address_allocation = "dynamic"
}

resource "azurerm_lb" "external_lb" {
  resource_group_name = "${var.resource_group}"
  name                = "az_external_lb"
  location            = "${var.location}"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = "${azurerm_public_ip.external_lb_pip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "external_backend_pool" {
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = "${azurerm_lb.external_lb.id}"
  name                = "az_external_backend_pool"
}

resource "azurerm_lb_rule" "external_lb_rule" {
  resource_group_name            = "${var.resource_group}"
  loadbalancer_id                = "${azurerm_lb.external_lb.id}"
  name                           = "az_external_backend_lbrule"
  protocol                       = "tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  enable_floating_ip             = false
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.external_backend_pool.id}"
  idle_timeout_in_minutes        = 5
  probe_id                       = "${azurerm_lb_probe.external_lb_probe.id}"
  depends_on                     = ["azurerm_lb_probe.external_lb_probe"]
}

resource "azurerm_lb_probe" "external_lb_probe" {
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = "${azurerm_lb.external_lb.id}"
  name                = "az_external_probe"
  protocol            = "tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_network_interface" "ext_nginx_nic" {
  name                = "external_nginx_nic_0${count.index}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  count               = "${var.vm_count}"

  ip_configuration {
    name                                    = "ext_nginx_ipconfig${count.index}"
    subnet_id                               = "${var.ext_nginx_subnet_id}"
    private_ip_address_allocation           = "Dynamic"
    load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.external_backend_pool.id}"]
  }
}

resource "azurerm_virtual_machine" "external_lb_pipnginx" {
  name                  = "external_nginx_0${count.index}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  availability_set_id   = "${var.external_nginx_availability_set_id}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${element(azurerm_network_interface.ext_nginx_nic.*.id, count.index)}"]
  count                 = 2

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name          = "external_nginx_osdisk_0${count.index}"
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
