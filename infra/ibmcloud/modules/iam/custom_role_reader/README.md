# _TF Module: Custom IAM Role_

- **IAM Role Actions Data Source:**
  - Defined using `data "ibm_iam_role_actions"` with:
    - **Service:** "power-iaas.workspace"
    - This retrieves all actions associated with the "Reader" role for the specified service.

- **Custom IAM Role:**
  - Created using `ibm_iam_custom_role` with:
    - **Name:** Specified by `var.custom_role_name`
    - **Display Name:** Also specified by `var.custom_role_name`
    - **Service:** "power-iaas.workspace"
    - **Actions:** Uses `concat` and `split` to include all actions retrieved from the "Reader" role, enabling read access.

This configuration establishes a custom IAM role for the Power IaaS workspace, providing the necessary permissions defined by the "Reader" role actions.
