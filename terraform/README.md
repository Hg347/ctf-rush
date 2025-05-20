[![Deploy AWS Account with Terraform](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml/badge.svg)](https://github.com/Hg347/ctf-rush/actions/workflows/terraform-deploy.yml)

# Developers
The following steps are only required if you are working with Terraform on AWS infrastructure.

## Setup Local Development Environment

### Requirements
- install `terraform cli`
- install `aws cli` 

## Initial AWS setup for terraform

1. Change into the directory `terraform` 

1. Ask project administrators to securely send the AWS credentials to you. For secure credential transfer, it's best they use a password safe, e.g. [bitwarden](https://bitwarden.com/products/send/).

1. Configure *aws cli* to use the `terraform-user`   
   ```bash
   aws configure --profile terraform
   ``` 
   `aws configure` save aws credentials in `~/.aws/credentials` and configurations in `~/.aws/config`.


