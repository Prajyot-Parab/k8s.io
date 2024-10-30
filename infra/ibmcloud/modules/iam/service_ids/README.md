# _TF Module: IAM Service ID_

- **IAM Service ID:**
  - Created using `ibm_iam_service_id` with:
    - **Name:** Specified by `var.service_id_name`

- **IAM Service API Key:**
  - Defined using `ibm_iam_service_api_key` with:
    - **Name:** Constructed as `${var.service_id_name}-apikey`
    - **IAM Service ID:** References the ID of the created service ID (`ibm_iam_service_id.service_id.iam_id`)

This configuration establishes a service ID in IBM IAM and generates an API key for programmatic access, ensuring secure integration with IBM Cloud services.
