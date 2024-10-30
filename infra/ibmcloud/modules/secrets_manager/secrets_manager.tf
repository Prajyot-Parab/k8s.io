resource "ibm_resource_instance" "secrets_manager" {
  name              = var.secrets_manager_name
  resource_group_id = var.resource_group_id
  service           = "secrets-manager"
  plan              = "standard"
  location          = var.secrets_manager_region
}

resource "ibm_sm_iam_credentials_configuration" "sm_iam_credentials_configuration_instance" {
  instance_id = ibm_resource_instance.secrets_manager.guid
  region      = var.secrets_manager_region
  name        = "sm_iam_cred_config"
  api_key     = var.apikey
}

resource "ibm_sm_iam_credentials_secret" "sm_iam_credentials_secret" {
  depends_on      = [ibm_sm_iam_credentials_configuration.sm_iam_credentials_configuration_instance]
  instance_id     = ibm_resource_instance.secrets_manager.guid
  region          = var.secrets_manager_region
  name            = var.sm_iam_cred_secret_name
  access_groups   = [var.access_group_id]
  custom_metadata = { "key" : "value" }
  rotation {
    auto_rotate = true
    interval    = 15
    unit        = "day"
  }
  ttl = "2592000"
}

resource "ibm_iam_authorization_policy" "policy" {
  source_service_name         = "secrets-manager"
  source_resource_instance_id = ibm_resource_instance.secrets_manager.guid
  target_service_name         = "cloud-object-storage"
  target_resource_instance_id = var.cos_instance_guid
  roles                       = ["Key Manager"]
}

resource "ibm_sm_service_credentials_secret" "sm_service_credentials_secret" {
  depends_on      = [ibm_iam_authorization_policy.policy]
  instance_id     = ibm_resource_instance.secrets_manager.guid
  region          = var.secrets_manager_region
  name            = var.sm_svc_cred_secret_name
  custom_metadata = { "key" : "value" }
  rotation {
    auto_rotate = true
    interval    = 15
    unit        = "day"
  }
  source_service {
    instance {
      crn = var.cos_bucket_crn
    }
    role {
      crn = "crn:v1:bluemix:public:iam::::serviceRole:Writer"
    }
    parameters = { "HMAC" : true }
  }
  ttl = "30d"
}
