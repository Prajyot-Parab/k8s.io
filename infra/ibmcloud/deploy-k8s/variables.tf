variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API key associated with user's identity"
  sensitive   = true

  validation {
    condition     = var.ibmcloud_api_key != "" && lower(var.ibmcloud_api_key) != "<key>"
    error_message = "The ibmcloud_api_key is required and cannot be empty."
  }
}

variable "cluster_name" {
  type    = string
  default = "k8s-power"
}

variable "public_key_file" {
  type        = string
  description = "Path to public key file"
  default     = "data/id_rsa.pub"
  # if empty, will default to ${path.cwd}/data/id_rsa.pub
}

variable "public_key" {
  type        = string
  description = "Public key"
  default     = ""
  # if empty, will read contents of file at var.public_key_file
}

variable "ibmcloud_region" {
  type        = string
  description = "The IBM Cloud region where you want to create the resources"
  default     = "us-south"

  validation {
    condition     = var.ibmcloud_region != "" && lower(var.ibmcloud_region) != "<region>"
    error_message = "The ibmcloud_region is required and cannot be empty."
  }
}

variable "ibmcloud_zone" {
  type        = string
  description = "The zone of an IBM Cloud region where you want to create Power System resources"
  default     = "us-south"

  validation {
    condition     = var.ibmcloud_zone != "" && lower(var.ibmcloud_zone) != "<zone>"
    error_message = "The ibmcloud_zone is required and cannot be empty."
  }
}

variable "kubernetes_version" {
  type    = string
  default = "v1.32.0"
}

variable "release_marker" {
  type    = string
  default = "release/v1.32.0"
}

variable "directory" {
  type    = string
  default = "release"
}

variable "machine_memory" {
  type    = string
  default = "32"
}
