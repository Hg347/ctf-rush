#
# ctf-rush, AWS environment
# terraform state file is remotely in an S3 bucket
#
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use the latest major version
    }
  }
  backend "s3" {
    bucket         = "ctfrush-terraform-state" 
    key            = "terraform/state/terraform.tfstate" 
    region         = "eu-central-1" # set this also in variables.tf, region!
    encrypt        = true 
  }
}


#
# Note 15.05.2025: pipeline does not know a profile, this is saved in local aws settings only
# the pipeline works with secrets and variables
#
#provider "aws" {
#  region = var.aws_settings.region
#  profile = "terraform" # AWS profile with the correct credentials
#  assume_role {
#    role_arn = "arn:aws:iam::149532386180:role/TerraformExecutionRole"
#  }
#}



resource "aws_vpc" "ctf" {
  cidr_block = "10.0.0.0/16"
  tags = var.ctf_tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.ctf.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = var.ctf_tags
}

output "vpc_id" {
  value = aws_vpc.ctf.id
}
