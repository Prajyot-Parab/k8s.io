variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API key associated with user's identity"
  sensitive   = true

  validation {
    condition     = var.ibmcloud_api_key != ""
    error_message = "The ibmcloud_api_key is required and cannot be empty."
  }
}
