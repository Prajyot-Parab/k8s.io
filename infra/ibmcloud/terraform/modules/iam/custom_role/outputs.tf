output "k8s_pvs_role_crn" {
  value = ibm_iam_custom_role.pvs.crn
}

output "k8s_sm_role_crn" {
  value = ibm_iam_custom_role.sm.crn
}
