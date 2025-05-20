# Initial Setup

This guide explains the very first and initial setup of AWS and terraform. This needs to be done only once to initially setup an AWS environment.

**Target Group**  
Project admins with AWS root access.

## AWS root user
Only the AWS root user has access rights to open the [AWS Management Console](https://signin.aws.amazon.com/). The root user is only seldomly used to manage basic things like the initial setup.
Almost everthings should be created via Infrastructure as Code (IaC), i.e. via terraform. Only IaC can be tracked and analyzed for security risks.


## Initial Setup
1. Create a root Account in AWS or `Sign in using root user email`
   - enable MFA
   - Go to `Budgets` and create a budget to be notified when costs reach 85% of that budget.
1. Go to `IAM` and create a `policy` named 'Bootstrap-Policy' and copy and paste the contents of the file [bootstrap-user-role.json](./bootstrap-user-role.json)   
1. Create a `bootstrap-user` for initial access via terraform
   - attach your policy of the previous step to that user
1. Create an `access key` for the bootstrap user. This enables the initial terraform scripts to act on behalf of that user.
   - choose purpose command line interface (CLI)
1. On your local development system change to folder`./terraform/initial setup` 
1. Execute following commands in the console on your local development system:
   ```bash
   aws configure --profile bootstrap
   ``` 
   This saves aws credentials in `~/.aws/credentials` and configuration in `~/.aws/config`.

1. Create an AWS S3 bucket to save the terraform state remotely and enable versioning of that bucket
   ```bash
   aws s3api create-bucket --bucket ctfrush-terraform-state --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1 --profile bootstrap

   aws s3api put-bucket-versioning --bucket ctfrush-terraform-state --versioning-configuration Status=Enabled --profile bootstrap
   ```

1. Execute terraform to create a service account for further terraform execution
   ```bash
   AWS_PROFILE=bootstrap terraform init
   AWS_PROFILE=bootstrap terraform plan -out=tfplan
   AWS_PROFILE=bootstrap terraform apply tfplan
   ```
1. Securely store the AWS credentials issued by Terraform in a password safe, 
   e.g. [bitwarden](https://bitwarden.com/products/personal/).
1. Securely send the AWS credentials to project developers working on Terraform pipelines. Zur sicheren Übertragung nutzen Sie eine entsprechende Funktion des Passwort-Safes, e.g. [bitwarden send](https://bitwarden.com/products/send/).

   **ATTENTION**  
   Allow only developers you know well and trust to work on Terraform pipelines.
   Only the few developers working on pipelines need these credentials.  
   **No one else!**  
   Never store credentials in git.

1. The bootstrap user is no longer needed as we have simply created a Terraform user instead that can be used for future setups via Terraform. Open the AWS root console and perform the following steps manually:
   1. Remove any policies to the `Bootstrap-User` 
   1. Deactivate the access key of the `Bootstrap-User` 
