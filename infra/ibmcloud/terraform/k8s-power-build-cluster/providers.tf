locals {
  key = var.ibmcloud_api_key
}

provider "ibm" {
  ibmcloud_api_key = local.key
  region           = var.ibmcloud_region
  zone             = var.ibmcloud_zone
}

provider "ibm" {
  alias            = "vpc"
  ibmcloud_api_key = local.key
  region           = var.vpc_region
}
