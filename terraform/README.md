[![Deploy AWS Account with Terraform](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml/badge.svg)](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml)


# Setup Local Development Environment

## Requirements
- install `terraform cli`
- install `aws cli` 

## Initial Setup

1. Ask the ctf-rush project admins for AWS credentials
1. Execute following commands on your local development system:
   - `aws configure` save aws credentials in `~/.aws/credentials` and configurations in `~/.aws/config`
   - terraform init
