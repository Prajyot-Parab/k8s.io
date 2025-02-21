output "pvs_access_group_id" {
  value = ibm_iam_access_group.pvs.id
}

output "billing_access_group_id" {
  value = ibm_iam_access_group.billing.id
}
