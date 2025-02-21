output "upstream_rg_id" {
  value = ibm_resource_group.upstream.id
}

output "k8s_rg_id" {
  value = ibm_resource_group.k8s_rg.id
}
