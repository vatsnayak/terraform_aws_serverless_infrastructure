resource "aws_apigatewayv2_api" "http_api" {
  name          = "get_rds_lambda_http_api"
  protocol_type = "HTTP"

  tags = {
    Name      = "get_rds_lambda_http_api"
    Terraform = "TRUE"
  }
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /lambda"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "prod"
  auto_deploy = true
}

# Grant API Gateway permission to invoke the Lambda
resource "aws_lambda_permission" "api_gateway_invoke_permission" {
  function_name = var.lambda_function_arn  # The Lambda ARN
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = aws_apigatewayv2_api.http_api.execution_arn
}