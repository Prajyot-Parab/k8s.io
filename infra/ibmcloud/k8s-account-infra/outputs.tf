output "k8s_resource_group_id" {
  value = module.resource_group.k8s_resource_group_id
}

output "k8s_role_reader_id" {
  value = module.iam_custom_role_reader.k8s_role_reader_id
}

output "k8s_access_group_id" {
  value = module.iam_access_groups.k8s_access_group_id
}

output "k8s_cos_instance_guid" {
  value = module.ibm_cos.k8s_cos_instance_guid
}

output "k8s_cos_instance_id" {
  value = module.ibm_cos.k8s_cos_instance_id
}

output "k8s_cos_bucket_crn" {
  value = module.ibm_cos.k8s_cos_bucket_crn
}
