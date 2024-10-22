# Lambda 1: api_lambda (with inline code)
resource "aws_lambda_function" "api_lambda" {
  function_name = var.lambda_function_name
  role          = var.lambda_exec_role_arn
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  filename         = "${path.module}/lambda_function_inline.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function_inline.zip")

  # Add AWS Pandas Layer
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python38:25"]

  tags = {
    Name      = "api_lambda"
    Terraform = "TRUE"
  }
}
