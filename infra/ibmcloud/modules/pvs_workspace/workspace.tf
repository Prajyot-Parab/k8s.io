resource "ibm_pi_workspace" "powervs_service_instance" {
  pi_name              = var.pi_workspace_name
  pi_datacenter        = var.datacenter
  pi_resource_group_id = var.resource_group_id
}
