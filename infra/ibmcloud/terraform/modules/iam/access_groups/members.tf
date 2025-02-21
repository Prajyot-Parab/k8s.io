resource "ibm_iam_access_group_members" "pvs" {
  access_group_id = ibm_iam_access_group.pvs.id
  ibm_ids = [
    "prajyot.parab2@ibm.com",
  ]
}

resource "ibm_iam_access_group_members" "billing" {
  access_group_id = ibm_iam_access_group.billing.id
  ibm_ids = [
    "prajyot.parab2@ibm.com",
  ]
}
