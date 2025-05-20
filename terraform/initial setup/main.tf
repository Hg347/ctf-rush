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

variable "aws_settings" {
  type = map(string)
  description = "General settings required in various modules"
  default = {
    account_id = "149532386180"
    region = "eu-central-1"  # set this also in main.tf backend s3 region!
    stage = "development"
  }
}

variable "ctf_tags" {
  type = map(string)
  default = {
    creator = "initial_terraform"
    creatorUrl = "https://github.com/Hg347/ctf-rush"
    project = "ctf-rush"
    environment = "Development"
    context = "terraform"
    purpose = "initial setup"
  }
}

#
# Create terraform-user
#
resource "aws_iam_user" "terraform_user" {
  name = "terraform-user"
  tags = var.ctf_tags
}

# create an assume role permission
resource "aws_iam_policy" "terraform_user_policy" {
  name   = "TerraformUserAssumeRolePolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = [ 
        "sts:AssumeRole"
      ]
      Resource = aws_iam_role.terraform_execution_role.arn
    }]
  })
}

# Attach permission to assume role to user
resource "aws_iam_user_policy_attachment" "terraform_user_policy_attach" {
  user       = aws_iam_user.terraform_user.name
  policy_arn = aws_iam_policy.terraform_user_policy.arn
}


#
# Create role for terraform user
#
resource "aws_iam_role" "terraform_execution_role" {
  name = "TerraformExecutionRole"
  tags = var.ctf_tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      # find aws account id: 
      # aws sts get-caller-identity --query Account --output text
      # AWS = "arn:aws:iam::<account-id>:user/terraform_user"
      Principal = { AWS = "arn:aws:iam::149532386180:user/terraform-user" }
      Action   = [ 
        "sts:AssumeRole",
        "sts:TagSession"
      ]
    }]
  })
}

#
# S3
# Define access rights (policy) for TerraformExecutionRole
resource "aws_iam_policy" "s3_terraform_policy" {
  name   = "S3Policy"
  tags = var.ctf_tags
  policy = file("policies/s3_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.s3_terraform_policy.arn
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


#
# Cognito
# Define access rights (policy) for TerraformExecutionRole
resource "aws_iam_policy" "cognito_terraform_policy" {
  name   = "CognitoPolicy"
  tags = var.ctf_tags
  policy = file("policies/cognito_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "cognito_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.cognito_terraform_policy.arn
}


#
# ECR
# Define access rights (policy) for TerraformExecutionRole
resource "aws_iam_policy" "ecr_terraform_policy" {
  name   = "EcrPolicy"
  tags = var.ctf_tags
  policy = file("policies/ecr_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "ecr_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.ecr_terraform_policy.arn
}


#
# IAM
# Define access rights (policy) for TerraformExecutionRole
resource "aws_iam_policy" "iam_terraform_policy" {
  name   = "IamPolicy"
  tags = var.ctf_tags
  policy = file("policies/iam_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "iam_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.iam_terraform_policy.arn
}


#
# Lambda
# Define access rights (policy) for TerraformExecutionRole
resource "aws_iam_policy" "lambda_terraform_policy" {
  name   = "LambdaPolicy"
  tags = var.ctf_tags
  policy = file("policies/lambda_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.lambda_terraform_policy.arn
}

#
# API Gateway
# Define access rights (policy) for TerraformExecutionRole
resource "aws_iam_policy" "apigateway_terraform_policy" {
  name   = "ApigatewayPolicy"
  tags = var.ctf_tags
  policy = file("policies/apigateway_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "apigateway_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.apigateway_terraform_policy.arn
}

# refer to line 42, create user
resource "aws_iam_access_key" "terraform_access_key" {
  user = aws_iam_user.terraform_user.name
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
