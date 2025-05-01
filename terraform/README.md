[![Deploy AWS Account with Terraform](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml/badge.svg)](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml)


# AWS Admins
Administrators of AWS need to access and open the [AWS Management Console](https://signin.aws.amazon.com/).

## Initial Setup
1. Create a root Account in AWS
   - enable MFA
1. Go to `IAM` and create a user for access via terraform
   - create your own `policy` and assign only the minimum required rights 
   - create a new `user group` and assign your new policy to that group
   - crete a new `user` and assign it to your new group
1. Go to `Budgets` and create a budget to be notified when costs reach 85% of that budget.




# Developers

## Setup Local Development Environment

### Requirements
- install `terraform cli`
- install `aws cli` 


### Initial Setup

1. Ask the AWS admins of the ctf-rush project for AWS credentials
1. Execute following commands in the console on your local development system:
   - `aws configure` save aws credentials in `~/.aws/credentials` and configurations in `~/.aws/config`
   - terraform init
1. Create an AWS S3 bucket to the terraform state remotely
   - `aws s3api create-bucket --bucket ctfrush-terraform-state --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1`
   - enable versioning: `aws s3api put-bucket-versioning --bucket ctfrush-terraform-state --versioning-configuration Status=Enabled`

