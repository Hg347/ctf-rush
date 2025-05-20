#
# Create new user
#
resource "aws_iam_user" "player_service" {
  name = "player-service"
  tags = var.ctf_tags
}

# create access key for that user
resource "aws_iam_access_key" "player_service_access_key" {
  user = aws_iam_user.player_service.name
}

output "aws_player_key_id" {
  value = aws_iam_access_key.player_service_access_key.id
}

output "secret_player_key" {
  value     = aws_iam_access_key.player_service_access_key.secret
  sensitive = true
}

# Attach permission to assume role to user
resource "aws_iam_user_policy_attachment" "player_service_policy_attach" {
  user       = aws_iam_user.player_service.name
  policy_arn = aws_iam_policy.player_service_policy.arn
}

# Create role for the new user
resource "aws_iam_role" "player_service_execution_role" {
  name = "PlayerServiceExecutionRole"
  tags = var.ctf_tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow"
      # find aws account id: 
      # aws sts get-caller-identity --query Account --output text
      # AWS = "arn:aws:iam::<account-id>:user/player_service"
      Principal = { AWS = "arn:aws:iam::149532386180:user/player-service" }
      Action   = [ 
        "sts:AssumeRole",
        "sts:TagSession"
      ]
    }]
  })
}

# Define policy (access rights) for ExecutionRole
resource "aws_iam_policy" "ecr_role_policy" {
  name   = "IamPolicy"
  tags = var.ctf_tags
  policy = file("policies/ecr_role_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to ExecutionRole
resource "aws_iam_role_policy_attachment" "ecr_role_policy_attach" {
  role       = aws_iam_role.player_service_execution_role.name
  policy_arn = aws_iam_policy.ecr_role_policy.arn
}

# create an assume role permission
resource "aws_iam_policy" "player_service_policy" {
  name   = "PlayerServiceAssumeRolePolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = [ 
        "sts:AssumeRole"
      ]
      Resource = aws_iam_role.player_service_execution_role.arn
    }]
  })
}