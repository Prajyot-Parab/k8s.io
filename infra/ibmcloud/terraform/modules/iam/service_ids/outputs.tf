output "k8s_service_id" {
  value = ibm_iam_service_id.service_id.id
}

output "k8s_apikey" {
  value     = ibm_iam_service_api_key.service_id_apikey.apikey
  sensitive = true
}
