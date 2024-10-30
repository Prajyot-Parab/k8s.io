output "bastion_private_ip" {
  value = data.ibm_pi_instance_ip.bastion_ip.ip
}

output "bastion_private_cidr" {
  value = data.ibm_pi_network.private_network.cidr
}

output "bastion_private_gateway" {
  value = data.ibm_pi_network.private_network.gateway
}

output "bastion_internal_ip" {
  value = data.ibm_pi_instance_ip.bastion_public_ip.ip
}

output "bastion_public_ip" {
  value = data.ibm_pi_instance_ip.bastion_public_ip.external_ip
}

output "control_plane_ips" {
  value = data.ibm_pi_instance_ip.control_plane_ip.*.ip
}

output "compute_ips" {
  value = data.ibm_pi_instance_ip.compute_ip.*.ip
}

output "loadbalancer_hostname" {
  value = module.load_balancer.hostname
}
