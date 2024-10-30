# _TF: IBM K8s Account Infrastructure_
This Terraform configuration sets up an organized structure for deploying various IBM Cloud resources using modules. 

1. **Resource Group Creation:**
   - A resource group is created using the `resource_group` module, with the name specified by `var.resource_group_name`.

2. **Custom IAM Role:**
   - The `iam_custom_role_reader` module defines a custom role based on the name provided by `var.custom_role_name`.

3. **IAM Access Groups:**
   - The `iam_access_groups` module creates access groups that depend on the custom role. It uses the access group name and custom role, associating them with the previously created resource group.

4. **Cloud Object Storage (COS) Setup:**
   - The `ibm_cos` module provisions a Cloud Object Storage instance and bucket, also dependent on the custom IAM role. It uses the COS instance and bucket names defined in variables and associates them with the resource group.

5. **Secrets Manager Configuration:**
   - Finally, the `secrets_manager` module sets up a Secrets Manager instance, using various parameters, including the access group ID from the IAM access groups and the COS instance GUID and CRN from the COS module. It specifies the region and API key for secure operations.

6. **Power Virtual Server Workspace:**
   - The `powervs_workspace_<datacenter>` module provisions a Power Virtual Server workspace in the specific datacenter, using a specific provider configuration. The workspace name is constructed from `var.pvs_workspace_name`, and it is associated with the previously created resource group.
