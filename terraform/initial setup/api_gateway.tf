
#
# API Gateway
# Define access rights (policy) for TerraformExecutionRole
#
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