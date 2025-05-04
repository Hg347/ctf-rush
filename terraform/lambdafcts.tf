#
# Create Lambda environment for serverless logic execution
#

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  tags = var.ctf_tags
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = { Service = "lambda.amazonaws.com" }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_ecr_access_policy" {
  name        = "lambda_ecr_access_policy"
  description = "Policy to allow Lambda to access ECR"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "arn:aws:ecr:${var.aws_settings.region}:${var.aws_settings.account_id}:repository/ctf-backend-services"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ecr_access_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_ecr_access_policy.arn
}

resource "aws_lambda_function" "player_lambda" {
  function_name = "ctf-player-service"
  role          = aws_iam_role.lambda_role.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.backend_services.repository_url}:player-service-latest"

  environment {
    variables = {
      ENV = var.aws_settings.stage
    }
  }

  tags = {
    Environment = "Development"
  }
}

output "lambda_function_arn" {
  value = aws_lambda_function.player_lambda.arn
}