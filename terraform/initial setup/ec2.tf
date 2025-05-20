#
# EC2
#

# Define access rights (policy) for ExecutionRole
resource "aws_iam_policy" "ec2_terraform_policy" {
  name   = "Ec2Policy"
  tags = var.ctf_tags
  policy = file("policies/ec2_terraform_policy.json")  # JSON-Datei einbinden
}

# Attach role policy to ExecutionRole
resource "aws_iam_role_policy_attachment" "ec2_policy_attach" {
  role       = aws_iam_role.terraform_execution_role.name
  policy_arn = aws_iam_policy.ec2_terraform_policy.arn
}