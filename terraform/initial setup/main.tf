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

output "aws_region" {
  value = var.aws_settings.region
}




