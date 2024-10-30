locals {
  key = var.api_key
}

provider "ibm" {
  ibmcloud_api_key = local.key
}

module "resource_group" {
  source              = "../modules/resource_group"
  resource_group_name = var.resource_group_name
}

module "iam_custom_role_reader" {
  source           = "../modules/iam/custom_role_reader"
  custom_role_name = var.custom_role_name
}

module "iam_access_groups" {
  depends_on        = [module.iam_custom_role_reader]
  source            = "../modules/iam/access_groups"
  access_group_name = var.access_group_name
  custom_role_name  = var.custom_role_name
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "ibm_cos" {
  depends_on        = [module.iam_custom_role_reader]
  source            = "../modules/cos"
  cos_instance_name = var.cos_instance_name
  cos_bucket_name   = var.cos_bucket_name
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "secrets_manager" {
  source                  = "../modules/secrets_manager"
  secrets_manager_name    = var.secrets_manager_name
  sm_iam_cred_secret_name = var.sm_iam_cred_secret_name
  sm_svc_cred_secret_name = var.sm_svc_cred_secret_name
  resource_group_id       = module.resource_group.k8s_resource_group_id
  access_group_id         = module.iam_access_groups.k8s_access_group_id
  cos_instance_guid       = module.ibm_cos.k8s_cos_instance_guid
  cos_bucket_crn          = module.ibm_cos.k8s_cos_instance_id
  secrets_manager_region  = var.secrets_manager_region
  apikey                  = local.key
}
