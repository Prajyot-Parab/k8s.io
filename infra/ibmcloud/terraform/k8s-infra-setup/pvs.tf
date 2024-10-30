locals {
  image_name = "CentOS-Stream-9"
}

resource "ibm_pi_workspace" "build_cluster" {
  pi_name              = "k8s-powervs-build-cluster-osa21"
  pi_datacenter        = "osa21"
  pi_resource_group_id = module.resource_group.k8s_rg_id
}

data "ibm_pi_catalog_images" "catalog_images" {
  pi_cloud_instance_id = ibm_pi_workspace.build_cluster.id
}

locals {
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.image_name]
}

# Copy image from catalog if not in the project and present in catalog
resource "ibm_pi_image" "image" {
  pi_image_id          = local.catalog_image[0].image_id
  pi_cloud_instance_id = ibm_pi_workspace.build_cluster.id
}

resource "ibm_pi_key" "sshkey" {
  pi_key_name          = "k8s-sshkey"
  pi_ssh_key           = module.secrets_manager.k8s_powervs_ssh_public_key
  pi_cloud_instance_id = ibm_pi_workspace.build_cluster.id
}
