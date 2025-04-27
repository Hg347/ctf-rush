#
# ctf-rush, AWS environment
# terraform state file is remotely in an S3 bucket
#
terraform {
  backend "s3" {
    bucket         = "ctfrush-terraform-state" 
    key            = "terraform/state/terraform.tfstate" 
    region         = "eu-central-1" 
    encrypt        = true 
  }
}

provider "aws" {
  region = "eu-central-1"
}

variable "ctf_tags" {
  default = {
    ctf:creator = "terraform"
  }
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = var.ctf_tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = var.ctf_tags
}

output "vpc_id" {
  value = aws_vpc.main.id
}
