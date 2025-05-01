#
# Identity and Access Management (IAM)
#
resource "aws_cognito_user_pool" "ctf" {
  name = "ctf-pool"
  tags = var.ctf_tags

  password_policy {
    minimum_length    = 9
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
  }

  mfa_configuration = "OPTIONAL" 
}


resource "aws_cognito_user_pool_client" "ctf" {
  name            = "ctf-app-client"
  user_pool_id    = aws_cognito_user_pool.ctf.id
  generate_secret = true
}

resource "aws_cognito_identity_pool" "ctf" {
  identity_pool_name               = "ctf-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id   = aws_cognito_user_pool_client.ctf.id
    provider_name = aws_cognito_user_pool.ctf.endpoint
  }

    tags = var.ctf_tags
}
