# _TF Module: Secrets Manager_

- **IBM Secrets Manager Instance:**
  - Created using `ibm_resource_instance` with:
    - Name: specified by `var.secrets_manager_name`
    - Resource group ID: specified by `var.resource_group_id`
    - Service: "secrets-manager"
    - Plan: "standard"
    - Location: specified by `var.secrets_manager_region`

- **IAM Credentials Configuration:**
  - Defined using `ibm_sm_iam_credentials_configuration` with:
    - Instance ID: references the Secrets Manager instance
    - Region: specified by `var.secrets_manager_region`
    - Name: "sm_iam_cred_config"
    - API Key: specified by `var.apikey`

- **IAM Credentials Secret:**
  - Created with `ibm_sm_iam_credentials_secret` with:
    - Depends on the IAM credentials configuration
    - Instance ID: references the Secrets Manager instance
    - Region: specified by `var.secrets_manager_region`
    - Name: specified by `var.sm_iam_cred_secret_name`
    - Access groups: specified by `var.access_group_id`
    - Custom metadata: includes a key-value pair
    - Rotation settings: auto-rotate every 15 days
    - Time-to-live (TTL): set to 30 days

- **Authorization Policy:**
  - Established using `ibm_iam_authorization_policy` with:
    - Source service name: "secrets-manager"
    - Source resource instance ID: references the Secrets Manager instance
    - Target service name: "cloud-object-storage"
    - Target resource instance ID: specified by `var.cos_instance_guid`
    - Roles: includes "Key Manager"

- **Service Credentials Secret:**
  - Created using `ibm_sm_service_credentials_secret` with:
    - Depends on the authorization policy
    - Instance ID: references the Secrets Manager instance
    - Region: specified by `var.secrets_manager_region`
    - Name: specified by `var.sm_svc_cred_secret_name`
    - Custom metadata: includes a key-value pair
    - Rotation settings: auto-rotate every 15 days
    - Source service configuration: links to a COS bucket with specific role and parameters
    - Time-to-live (TTL): set to 30 days

This configuration establishes a comprehensive setup for managing secrets and credentials within IBM Cloud, integrating with the Secrets Manager and other services.
