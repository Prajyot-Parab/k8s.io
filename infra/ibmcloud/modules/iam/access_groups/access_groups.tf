resource "ibm_iam_access_group" "access_group" {
  name        = var.access_group_name
  description = var.access_group_name
}

resource "ibm_iam_access_group_policy" "policy" {
  access_group_id = ibm_iam_access_group.access_group.id
  roles           = [var.custom_role_name]

  resources {
    service           = "power-iaas"
    resource_group_id = var.resource_group_id
  }
}
