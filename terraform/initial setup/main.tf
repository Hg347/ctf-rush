#
# Initial AWS environment
# terraform state file is remotely in an S3 bucket
#

provider "aws" {
  region = "eu-central-1"
  profile = "bootstrap" # AWS profile with the correct credentials
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use the latest major version
    }
  }
  backend "s3" {
    bucket         = "ctfrush-terraform-state" 
    key            = "terraform/state/initial-tfuser.tfstate" 
    region         = "eu-central-1" 
    encrypt        = true 
  }
}




#
# EC2
# Define access rights (policy) for TerraformExecutionRole
resource "aws_iam_policy" "ec2_terraform_policy" {
  name   = "Ec2Policy"
  tags = var.ctf_tags
  policy = file("policies/ec2_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "ec2_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.ec2_terraform_policy.arn
}


output "aws_region" {
  value = var.aws_settings.region
}

output "aws_access_key_id" {
  value = aws_iam_access_key.terraform_access_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.terraform_access_key.secret
  sensitive = true
}
