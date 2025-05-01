resource "aws_api_gateway_rest_api" "ctf" {
  name        = "ctf-api-gateway"
  description = "API Gateway for CTF Rush Player Service"
}

resource "aws_api_gateway_resource" "players" {
  rest_api_id = aws_api_gateway_rest_api.ctf.id
  parent_id   = aws_api_gateway_rest_api.ctf.root_resource_id
  path_part   = "players"
}

resource "aws_api_gateway_method" "players_get" {
  rest_api_id   = aws_api_gateway_rest_api.ctf.id
  resource_id   = aws_api_gateway_resource.players.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "players_post" {
  rest_api_id   = aws_api_gateway_rest_api.ctf.id
  resource_id   = aws_api_gateway_resource.players.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "players_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.ctf.id
  resource_id             = aws_api_gateway_resource.players.id
  http_method             = aws_api_gateway_method.players_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.player_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "players_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.ctf.id
  resource_id             = aws_api_gateway_resource.players.id
  http_method             = aws_api_gateway_method.players_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.player_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "ctf" {
  rest_api_id = aws_api_gateway_rest_api.ctf.id
  stage_name  = "dev"
}

output "api_gateway_invoke_url" {
  value = "${aws_api_gateway_rest_api.ctf.execution_arn}/dev/players"
}