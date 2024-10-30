resource "ibm_is_vpc" "vpc" {
  name           = "k8s-vpc"
  resource_group = var.resource_group_id
}

resource "ibm_is_subnet" "subnet" {
  name                     = "k8s-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  resource_group           = var.resource_group_id
  total_ipv4_address_count = 256
  zone                     = "jp-osa-1"
}

locals {
  tcp_ports = [6443]
}

resource "ibm_is_security_group_rule" "inbound_ports" {
  count     = length(local.tcp_ports)
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  tcp {
    port_min = local.tcp_ports[count.index]
    port_max = local.tcp_ports[count.index]
  }
}
