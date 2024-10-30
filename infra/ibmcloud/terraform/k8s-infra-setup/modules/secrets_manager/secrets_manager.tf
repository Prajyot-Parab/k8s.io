locals {
  secrets_manager_region = "us-south"
  secrets_manager_name   = "k8s-secrets-ppc64le"
}

resource "ibm_resource_instance" "secrets_manager" {
  name              = local.secrets_manager_name
  resource_group_id = var.resource_group_id
  service           = "secrets-manager"
  plan              = "standard"
  location          = local.secrets_manager_region

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

# RSA key of size 4096 bits
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "ibm_sm_arbitrary_secret" "ssh_private_key" {
  name        = "powervs-ssh-private-key"
  instance_id = ibm_resource_instance.secrets_manager.guid
  region      = local.secrets_manager_region
  labels      = ["powervs-ssh-private-key"]
  payload     = tls_private_key.private_key.private_key_openssh
}

resource "ibm_sm_arbitrary_secret" "ssh_public_key" {
  name        = "powervs-ssh-public-key"
  instance_id = ibm_resource_instance.secrets_manager.guid
  region      = local.secrets_manager_region
  labels      = ["powervs-ssh-public-key"]
  payload     = tls_private_key.private_key.public_key_openssh
}
