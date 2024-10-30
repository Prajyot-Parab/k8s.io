# _TF Module: PowerVS Workspace_

- **IBM PowerVS Workspace Instance:**
  - Defined using `ibm_pi_workspace` with:
    - Workspace name: specified by `var.pi_workspace_name`
    - Datacenter: specified by `var.datacenter`
    - Resource group ID: specified by `var.resource_group_id`

This configuration sets up a Power Virtual Server workspace, ensuring it is correctly assigned to the designated datacenter and resource group.
