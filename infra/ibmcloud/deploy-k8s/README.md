# Deployer Setup Guide

This guide will walk you through the process of setting up your deployer machine, configuring the necessary tools, and deploying infrastructure using Terraform.

## Prerequisites
- A deployer machine (Linux)
- IBM Cloud account with access to create API keys

### Step 1: Run the `setup.sh` file on your deployer machine
The `setup.sh` script will install and set up the necessary tools on your machine, including Terraform, Golang, kubetest2, kubetest2 tf plugin, and kubectl. 

```bash
./setup.sh
```
This will automatically install and configure the required tools on your deployer machine.

### Step 2: Place your SSH key pair in the data directory
You need an SSH key pair (public and private) for authentication. Follow these steps:

- Locate your public SSH key and private SSH key (commonly named `id_rsa.pub` and `id_rsa`).
- Copy both files into the data directory of your project.
- Rename the files if necessary:
  - Public key: `id_rsa.pub`
  - Private key: `id_rsa`
- Set permissions for the private key. Run the following command to ensure proper security:

```bash
chmod 600 data/id_rsa
```

### Step 3: Create a new IBM Cloud API key and set it in the vars.tf file
You need an IBM Cloud API key for authentication. Here's how to create one:

- Log in to IBM Cloud.
- Go to Manage > Access (IAM) and click on API Keys.
- Click Create an IBM Cloud API key and follow the instructions to generate a new API key.
- Once the key is created, copy the API key to your clipboard.
- Open the `vars.tf` file in your project directory and set the API key variable.

### Step 4: Initialize Terraform
This step initializes Terraform and downloads the required provider plugins and modules.

```bash
terraform init
```

### Step 5: Apply Terraform
Now you are ready to deploy your infrastructure. Run the following command:

```bash
terraform apply -var-file=var.tfvars
```

#### _Note_: To know more about the other customizable options refer the `variables.tf` file.

This will apply the Terraform configuration and prompt you to confirm the changes. Type yes when prompted to proceed with the deployment.
