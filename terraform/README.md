[![Deploy AWS Account with Terraform](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml/badge.svg)](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml)


# Setup Local Development Environment

## Requirements
- install `terraform cli`
- install `aws cli` 

## Initial Setup

1. Ask the ctf-rush project admins for AWS credentials
1. Execute following commands in the console on your local development system:
   - `aws configure` save aws credentials in `~/.aws/credentials` and configurations in `~/.aws/config`
   - terraform init
1. Create an AWS S3 bucket to the terraform state remotely
   - `aws s3api create-bucket --bucket ctfrush-terraform-state --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1`
   - enable versioning: `aws s3api put-bucket-versioning --bucket ctfrush-terraform-state --versioning-configuration Status=Enabled`
