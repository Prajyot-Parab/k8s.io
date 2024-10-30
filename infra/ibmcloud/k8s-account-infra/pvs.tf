/*
provider "ibm" {
  alias            = "dal12"
  ibmcloud_api_key = local.key
  region           = "dal"
  zone             = "dal12"
}

provider "ibm" {
  alias            = "us-south"
  ibmcloud_api_key = local.key
  region           = "us-south"
  zone             = "us-south"
}

provider "ibm" {
  alias            = "wdc06"
  ibmcloud_api_key = local.key
  region           = "wdc"
  zone             = "wdc06"
}

provider "ibm" {
  alias            = "us-east"
  ibmcloud_api_key = local.key
  region           = "us-east"
  zone             = "us-east"
}

provider "ibm" {
  alias            = "sao01"
  ibmcloud_api_key = local.key
  region           = "sao"
  zone             = "sao01"
}

provider "ibm" {
  alias            = "tor01"
  ibmcloud_api_key = local.key
  region           = "tor"
  zone             = "tor01"
}

provider "ibm" {
  alias            = "mon01"
  ibmcloud_api_key = local.key
  region           = "mon"
  zone             = "mon01"
}

provider "ibm" {
  alias            = "eu-de-1"
  ibmcloud_api_key = local.key
  region           = "eu-de"
  zone             = "eu-de-1"
}

provider "ibm" {
  alias            = "eu-de-2"
  ibmcloud_api_key = local.key
  region           = "eu-de"
  zone             = "eu-de-2"
}

provider "ibm" {
  alias            = "lon04"
  ibmcloud_api_key = local.key
  region           = "lon"
  zone             = "lon04"
}

provider "ibm" {
  alias            = "lon06"
  ibmcloud_api_key = local.key
  region           = "lon"
  zone             = "lon06"
}

provider "ibm" {
  alias            = "mad02"
  ibmcloud_api_key = local.key
  region           = "mad"
  zone             = "mad02"
}

provider "ibm" {
  alias            = "syd04"
  ibmcloud_api_key = local.key
  region           = "syd"
  zone             = "syd04"
}

provider "ibm" {
  alias            = "syd05"
  ibmcloud_api_key = local.key
  region           = "syd"
  zone             = "syd05"
}
*/

provider "ibm" {
  alias            = "tok04"
  ibmcloud_api_key = local.key
  region           = "tok"
  zone             = "tok04"
}

provider "ibm" {
  alias            = "osa21"
  ibmcloud_api_key = local.key
  region           = "osa"
  zone             = "osa21"
}

provider "ibm" {
  alias            = "che01"
  ibmcloud_api_key = local.key
  region           = "che"
  zone             = "che01"
}

/*
module "powervs_workspace_dal12" {
  providers = {
    ibm = ibm.dal12
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "dal12"
  pi_workspace_name = "${var.pvs_workspace_name}-dal12"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_us_south" {
  providers = {
    ibm = ibm.us-south
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "us-south"
  pi_workspace_name = "${var.pvs_workspace_name}-us-south"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_wdc06" {
  providers = {
    ibm = ibm.wdc06
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "wdc06"
  pi_workspace_name = "${var.pvs_workspace_name}-wdc06"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_us_east" {
  providers = {
    ibm = ibm.us-east
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "us-east"
  pi_workspace_name = "${var.pvs_workspace_name}-us-east"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_sao01" {
  providers = {
    ibm = ibm.sao01
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "sao01"
  pi_workspace_name = "${var.pvs_workspace_name}-sao01"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_tor01" {
  providers = {
    ibm = ibm.tor01
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "tor01"
  pi_workspace_name = "${var.pvs_workspace_name}-tor01"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_mon01" {
  providers = {
    ibm = ibm.mon01
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "mon01"
  pi_workspace_name = "${var.pvs_workspace_name}-mon01"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_eu_de_1" {
  providers = {
    ibm = ibm.eu-de-1
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "eu-de-1"
  pi_workspace_name = "${var.pvs_workspace_name}-eu-de-1"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_eu_de_2" {
  providers = {
    ibm = ibm.eu-de-2
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "eu-de-2"
  pi_workspace_name = "${var.pvs_workspace_name}-eu-de-2"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_lon04" {
  providers = {
    ibm = ibm.lon04
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "lon04"
  pi_workspace_name = "${var.pvs_workspace_name}-lon04"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_lon06" {
  providers = {
    ibm = ibm.lon06
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "lon06"
  pi_workspace_name = "${var.pvs_workspace_name}-lon06"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_mad02" {
  providers = {
    ibm = ibm.mad02
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "mad02"
  pi_workspace_name = "${var.pvs_workspace_name}-mad02"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_syd04" {
  providers = {
    ibm = ibm.syd04
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "syd04"
  pi_workspace_name = "${var.pvs_workspace_name}-syd04"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_syd05" {
  providers = {
    ibm = ibm.syd05
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "syd05"
  pi_workspace_name = "${var.pvs_workspace_name}-syd05"
  resource_group_id = module.resource_group.k8s_resource_group_id
}
*/

module "powervs_workspace_tok04" {
  providers = {
    ibm = ibm.tok04
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "tok04"
  pi_workspace_name = "${var.pvs_workspace_name}-tok04"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_osa21" {
  providers = {
    ibm = ibm.osa21
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "osa21"
  pi_workspace_name = "${var.pvs_workspace_name}-osa21"
  resource_group_id = module.resource_group.k8s_resource_group_id
}

module "powervs_workspace_che01" {
  providers = {
    ibm = ibm.che01
  }
  source            = "../modules/pvs_workspace"
  datacenter        = "che01"
  pi_workspace_name = "${var.pvs_workspace_name}-che01"
  resource_group_id = module.resource_group.k8s_resource_group_id
}
