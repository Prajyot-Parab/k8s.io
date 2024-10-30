module "resource_group" {
  source = "./modules/resource_group"
}

module "secrets_manager" {
  source            = "./modules/secrets_manager"
  resource_group_id = module.resource_group.k8s_rg_id
}

module "vpc" {
  providers = {
    ibm = ibm.vpc
  }
  source            = "./modules/vpc"
  resource_group_id = module.resource_group.k8s_rg_id
}

module "transit_gateway" {
  depends_on = [module.vpc]
  providers = {
    ibm = ibm.vpc
  }
  source            = "./modules/transit_gateway"
  resource_group_id = module.resource_group.k8s_rg_id
  vpc_crn           = module.vpc.crn
  powervs_crn       = ibm_pi_workspace.build_cluster.crn
}
