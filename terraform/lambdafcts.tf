#
# Create Lambda envrionment for serverless logic execution
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

# resource "aws_lambda_function" "example_lambda" {
#  function_name = "example-lambda-function"
#  runtime       = "python3.9" # Beispiel für Python; ändern Sie dies bei Bedarf
#  role          = aws_iam_role.lambda_role.arn
#  handler       = "lambda_function.lambda_handler"
#  filename      = "example_lambda.zip" # Hochgeladenes Zip der Funktion
#
#  environment {
#    variables = {
#      ENV = "development"
#    }
#  }
#
#  tags = {
#    Environment = "Development"
#  }
# }
