#
# Create terraform-user
#
resource "aws_iam_user" "terraform_user" {
  name = "terraform-user"
  tags = var.ctf_tags
}

# create access key for that user
resource "aws_iam_access_key" "aws_terraform_key" {
  user = aws_iam_user.terraform_user.name
}

output "aws_terraform_key_id" {
  value = aws_iam_access_key.aws_terraform_key.id
}

output "aws_secret_terraform_key" {
  value     = aws_iam_access_key.aws_terraform_key.secret
  sensitive = true
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

# Define policy (access rights) for TerraformExecutionRole
resource "aws_iam_policy" "iam_terraform_policy" {
  name   = "TerraformRolePolicy"
  tags = var.ctf_tags
  policy = file("policies/iam_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to TerraformExecutionRole
resource "aws_iam_role_policy_attachment" "iam_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.iam_terraform_policy.arn
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



