variable "api_key" {
  type      = string
  sensitive = true
  default   = "<key>"
}

variable "resource_group_name" {
  type    = string
  default = "k8s-infra-management"
}

variable "custom_role_name" {
  type    = string
  default = "ReaderRolePVS"
}

variable "service_id_name" {
  type    = string
  default = "k8s-infra-iam-service-id"
}

variable "access_group_name" {
  type    = string
  default = "k8s-infra-access-group-read"
}

variable "pvs_workspace_name" {
  type    = string
  default = "k8s-infra-boskos"
}

variable "cos_instance_name" {
  type    = string
  default = "k8s-cos-instance"
}

variable "cos_bucket_name" {
  type    = string
  default = "k8s-cos-bucket"
}

variable "secrets_manager_name" {
  type    = string
  default = "k8s-secret-manager"
}

variable "secrets_manager_region" {
  type    = string
  default = "us-south"
}

variable "sm_iam_cred_secret_name" {
  type    = string
  default = "k8s-sm-iam-secret"
}

variable "sm_svc_cred_secret_name" {
  type    = string
  default = "k8s-sm-svc-secret"
}
