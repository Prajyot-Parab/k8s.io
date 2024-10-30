output "secrets_manager_id" {
  value = module.secrets_manager.k8s_secrets_manager_id
}

output "powervs_service_instance_id" {
  value = ibm_pi_workspace.build_cluster.id
}
