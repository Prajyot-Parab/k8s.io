output "k8s_secrets_manager_id" {
  value = ibm_resource_instance.secrets_manager.guid
}
