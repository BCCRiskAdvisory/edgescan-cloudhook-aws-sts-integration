# Edgescan Cloudhook AWS STS Integration

A Terraform template to generate an AWS IAM Role for automated Edgescan onboarding using STS.

This Terraform Template will generate:

- An IAM Role with the following policies:
    - AmazonEC2ReadOnlyAccess
    - AmazonRoute53ReadOnlyAccess
    - An inline policy to fetch the AWS account's alias
    - The IAM trust relationship to allow Edgescan assume the role

## Prerequisites
### 1. Installing Terraform

The official instructions on installing Terraform can be found here: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### 2. Installing AWS CLI

The official instructions on installing the AWS CLI can be found here: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

## Instructions on running this template

1. Initialise the Terraform Template by running:

   ```
   terraform init
   ```

2. Apply the template by running:

   ```
   terraform apply
   ```

   This will create an IAM Role named *'EdgescanCloudhookIntegration'*.

   Alternatively, if you want to set a custom name for the AWS IAM Role (e.g. to match company naming policies), you can instead apply the template with the following command:

   ```
   terraform apply -var="role=<your custom role name>"
   ```

3. The apply command will prompt you for the Edgescan ID provided by Edgescan. It will list the AWS resources that will be created, and prompt you to apply these changes with 'y'.

4. At the end of the Terraform apply, the **external_id** and **role_arn** will be listed. Take note of this values and send them to Edgescan.
