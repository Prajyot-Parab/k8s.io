resource "ibm_tg_gateway" "transit_gateway" {
  name           = "k8s-tgw"
  location       = "jp-osa"
  global         = true
  resource_group = var.resource_group_id
}

resource "ibm_tg_connection" "tg_connection_vpc" {
  gateway      = ibm_tg_gateway.transit_gateway.id
  network_type = "vpc"
  name         = "k8s-conn-vpc"
  network_id   = var.vpc_crn
}

resource "ibm_tg_connection" "tg_connection_powervs" {
  gateway      = ibm_tg_gateway.transit_gateway.id
  network_type = "power_virtual_server"
  name         = "k8s-conn-powervs"
  network_id   = var.powervs_crn
}
