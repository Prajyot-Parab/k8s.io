resource "ibm_iam_service_id" "service_id" {
  name = var.service_id_name
}

resource "ibm_iam_service_api_key" "service_id_apikey" {
  name           = "${var.service_id_name}-apikey"
  iam_service_id = ibm_iam_service_id.service_id.iam_id
}
