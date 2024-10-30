module "load_balancer" {

  providers = {
    ibm = ibm.vpc
  }

  depends_on          = [ibm_pi_instance.control_plane]
  source              = "./modules/load_balancer"
  control_plane_count = var.control_plane["count"]
  control_plane_ips   = data.ibm_pi_instance_ip.control_plane_ip.*.ip
  vpc_name            = var.vpc_name
  resource_group_name = var.resource_group_name
}
