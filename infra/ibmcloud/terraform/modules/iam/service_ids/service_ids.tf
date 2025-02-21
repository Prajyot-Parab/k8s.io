locals {
  iam_service_id_name    = "k8s-service-id"
  service_id_apikey_name = "k8s-apikey"
}

resource "ibm_iam_service_id" "service_id" {
  name = local.iam_service_id_name
}

resource "ibm_iam_service_api_key" "service_id_apikey" {
  name           = local.service_id_apikey_name
  iam_service_id = ibm_iam_service_id.service_id.iam_id
  store_value    = true
}

resource "ibm_iam_service_policy" "policy_sm" {
  iam_service_id = ibm_iam_service_id.service_id.id
  roles          = ["SMRole"]

  resources {
    service           = "secrets-manager"
    resource_group_id = var.resource_group_id
  }
}

resource "ibm_iam_service_policy" "policy_iam_groups" {
  iam_service_id = ibm_iam_service_id.service_id.id
  roles          = ["Editor"]

  resources {
    service           = "iam-groups"
    resource_group_id = var.resource_group_id
  }
}

resource "ibm_iam_service_policy" "policy_iam_identity" {
  iam_service_id = ibm_iam_service_id.service_id.id
  roles          = ["Operator"]

  resources {
    service           = "iam-identity"
    resource_group_id = var.resource_group_id
  }
}
