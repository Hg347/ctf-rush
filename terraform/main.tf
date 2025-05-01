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
    creator = "ctf_terraform"
    creatorUrl = "https://github.com/Hg347/ctf-rush"
    environment = "Development"
  }
}


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
