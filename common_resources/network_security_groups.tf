resource "azurerm_network_security_group" "nsg_external_lb" {
  name 			            = "nsg-external-lb"
  location 		          = "${var.location}"
  resource_group_name 	= "${var.resource_group}"

  security_rule {
	name 			  = "AllowHTTP"
	priority		= 200
	direction		= "Inbound"
	access 			= "Allow"
	protocol 		= "Tcp"
	source_port_range           = "*"
  destination_port_range     	= "80"
  source_address_prefix      	= "Internet"
  destination_address_prefix 	= "*"
  }

  security_rule {
	name 			  = "AllowHTTPS"
	priority		= 300
	direction		= "Inbound"
	access 			= "Allow"
	protocol 		= "Tcp"
	source_port_range           = "*"
  destination_port_range     	= "443"
  source_address_prefix      	= "Internet"
  destination_address_prefix 	= "*"
  }
}
