resource "ibm_resource_group" "upstream" {
  name = "upstream-power"
}

resource "ibm_resource_group" "k8s_rg" {
  name = "k8s-project"
}
