module "resource_group" {
  source = "./modules/resource_group"
}

module "iam_custom_role" {
  source = "./modules/iam/custom_role"
}

module "service_ids" {
  depends_on        = [module.iam_custom_role]
  source            = "./modules/iam/service_ids"
  resource_group_id = module.resource_group.k8s_rg_id
}

module "iam_access_groups" {
  depends_on        = [module.iam_custom_role]
  source            = "./modules/iam/access_groups"
  resource_group_id = module.resource_group.k8s_rg_id
}

module "ibm_cos" {
  source            = "./modules/cos"
  prefix            = var.prefix
  resource_group_id = module.resource_group.upstream_rg_id
}

module "secrets_manager" {
  source            = "./modules/secrets_manager"
  prefix            = var.prefix
  resource_group_id = module.resource_group.k8s_rg_id
  access_group_id   = module.iam_access_groups.pvs_access_group_id
  cos_instance_guid = module.ibm_cos.k8s_cos_instance_guid
  cos_instance_id   = module.ibm_cos.k8s_cos_instance_id
  apikey            = module.service_ids.k8s_apikey
}
