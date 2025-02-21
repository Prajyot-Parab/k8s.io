resource "ibm_iam_access_group" "pvs" {
  name = "k8s-project-powervs"
}

resource "ibm_iam_access_group_policy" "pvs" {
  access_group_id = ibm_iam_access_group.pvs.id
  roles           = ["PVSRole"]

  resources {
    service           = "power-iaas"
    resource_group_id = var.resource_group_id
  }
}

resource "ibm_iam_access_group" "billing" {
  name = "k8s-project-billing"
}

resource "ibm_iam_access_group_policy" "billing" {
  access_group_id = ibm_iam_access_group.billing.id
  roles           = ["Viewer"]

  resources {
    service           = "billing"
    resource_group_id = var.resource_group_id
  }
}
