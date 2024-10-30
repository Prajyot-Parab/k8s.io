locals {
  api_servers       = var.control_plane_ips
  api_servers_count = var.control_plane_count
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

data "ibm_resource_group" "group" {
  name = var.resource_group_name
}

resource "ibm_is_lb" "load_balancer_external" {
  name           = "k8s-control-plane-api-lb"
  resource_group = data.ibm_resource_group.group.id
  subnets        = data.ibm_is_vpc.vpc.subnets.*.id
  type           = "public"
}

# api listener and backend pool (external)
resource "ibm_is_lb_listener" "api_listener_external" {
  lb           = ibm_is_lb.load_balancer_external.id
  port         = 6443
  protocol     = "tcp"
  default_pool = ibm_is_lb_pool.api_pool_external.id
}

resource "ibm_is_lb_pool" "api_pool_external" {
  depends_on = [ibm_is_lb.load_balancer_external]

  name           = "api-server"
  lb             = ibm_is_lb.load_balancer_external.id
  algorithm      = "round_robin"
  protocol       = "tcp"
  health_delay   = 60
  health_retries = 5
  health_timeout = 30
  health_type    = "tcp"
}

resource "ibm_is_lb_pool_member" "api_member_external" {
  depends_on = [ibm_is_lb_listener.api_listener_external]
  count      = local.api_servers_count

  lb             = ibm_is_lb.load_balancer_external.id
  pool           = ibm_is_lb_pool.api_pool_external.id
  port           = 6443
  target_address = local.api_servers[count.index]
}
