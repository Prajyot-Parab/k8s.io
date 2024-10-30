data "ibm_iam_role_actions" "all" {
  service = "power-iaas.workspace"
}

resource "ibm_iam_custom_role" "read" {
  name         = var.custom_role_name
  display_name = var.custom_role_name
  service      = "power-iaas.workspace"
  actions      = concat(split(",", data.ibm_iam_role_actions.all.actions["Reader"]))
}
