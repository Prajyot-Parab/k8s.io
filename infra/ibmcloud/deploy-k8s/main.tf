locals {
  key             = var.ibmcloud_api_key
  image_name      = "CentOS-Stream-9"
  catalog_image   = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.image_name]
  public_key_file = var.public_key_file == "" ? "${path.cwd}/data/id_rsa.pub" : var.public_key_file
  public_key      = var.public_key == "" ? file(coalesce(local.public_key_file, "/dev/null")) : var.public_key
}

provider "ibm" {
  ibmcloud_api_key = local.key
  region           = var.ibmcloud_region
  zone             = var.ibmcloud_zone
}

resource "ibm_resource_group" "resource_group" {
  name = "k8s-power"
}

resource "ibm_pi_workspace" "powervs_service_instance" {
  pi_name              = "k8s-workspace"
  pi_datacenter        = var.ibmcloud_zone
  pi_resource_group_id = ibm_resource_group.resource_group.id
}

data "ibm_pi_catalog_images" "catalog_images" {
  pi_cloud_instance_id = ibm_pi_workspace.powervs_service_instance.id
}

resource "ibm_pi_image" "image" {
  pi_image_id          = local.catalog_image[0].image_id
  pi_cloud_instance_id = ibm_pi_workspace.powervs_service_instance.id
}

resource "ibm_pi_key" "key" {
  pi_cloud_instance_id = ibm_pi_workspace.powervs_service_instance.id
  pi_key_name          = "my-keypair"
  pi_ssh_key           = local.public_key
}

resource "null_resource" "kubetest2" {
  depends_on = [ibm_pi_image.image, ibm_pi_key.key]

  triggers = {
    TF_VAR_powervs_api_key = local.key
    powervs_region         = var.ibmcloud_region
    powervs_zone           = var.ibmcloud_zone
    powervs_service_id     = ibm_pi_workspace.powervs_service_instance.id
    cluster_name           = var.cluster_name
  }

  provisioner "local-exec" {
    command = "export GOPATH=$HOME/go && export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin && kubetest2 tf --powervs-image-name $POWERVS_IMAGE_NAME --powervs-memory $POWERVS_MEMORY --powervs-region $POWERVS_REGION --powervs-zone $POWERVS_ZONE --powervs-service-id $POWERVS_SERVICE_ID --powervs-ssh-key $SSH_KEY --ssh-private-key $SSH_PRIVATE_KEY_PATH --build-version $K8S_VERSION --cluster-name $CLUSTER_NAME --workers-count 2 --release-marker $RELEASE_MARKER --directory $DIRECTORY --up --ignore-cluster-dir --auto-approve"
    environment = {
      TF_VAR_powervs_api_key = local.key
      POWERVS_IMAGE_NAME     = local.image_name
      POWERVS_REGION         = var.ibmcloud_region
      POWERVS_ZONE           = var.ibmcloud_zone
      POWERVS_SERVICE_ID     = ibm_pi_workspace.powervs_service_instance.id
      SSH_KEY                = ibm_pi_key.key.name
      POWERVS_MEMORY         = var.machine_memory
      CLUSTER_NAME           = var.cluster_name
      RELEASE_MARKER         = var.release_marker
      DIRECTORY              = var.directory
      SSH_PRIVATE_KEY_PATH   = "${path.cwd}/data/id_rsa"
      K8S_VERSION            = var.kubernetes_version
    }
  }

  provisioner "local-exec" {
    when       = destroy
    on_failure = continue
    command    = "export GOPATH=$HOME/go && export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin && kubetest2 tf --powervs-region $POWERVS_REGION --powervs-zone $POWERVS_ZONE --powervs-service-id $POWERVS_SERVICE_ID --cluster-name $CLUSTER_NAME --ignore-cluster-dir true --down --auto-approve --ignore-destroy-errors"
    environment = {
      TF_VAR_powervs_api_key = "${self.triggers.TF_VAR_powervs_api_key}"
      POWERVS_REGION         = "${self.triggers.powervs_region}"
      POWERVS_ZONE           = "${self.triggers.powervs_zone}"
      POWERVS_SERVICE_ID     = "${self.triggers.powervs_service_id}"
      CLUSTER_NAME           = "${self.triggers.cluster_name}"
      SSH_PRIVATE_KEY_PATH   = "${path.cwd}/data/id_rsa"
    }
  }
}
