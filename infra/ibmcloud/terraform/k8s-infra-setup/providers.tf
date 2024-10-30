locals {
  key    = var.ibmcloud_api_key
  region = "osa"
  zone   = "osa21"
}

provider "ibm" {
  ibmcloud_api_key = local.key
  region           = local.region
  zone             = local.zone
}

provider "ibm" {
  alias            = "vpc"
  ibmcloud_api_key = local.key
  region           = "jp-osa"
}
