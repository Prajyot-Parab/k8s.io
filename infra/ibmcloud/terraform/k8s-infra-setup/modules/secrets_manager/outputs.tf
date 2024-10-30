output "k8s_secrets_manager_id" {
  value = ibm_resource_instance.secrets_manager.guid
}

output "k8s_powervs_ssh_public_key" {
  value = tls_private_key.private_key.public_key_openssh
}
