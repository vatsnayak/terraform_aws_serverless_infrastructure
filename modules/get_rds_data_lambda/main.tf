# Lambda 2: get_rds_data_lambda (with ZIP file for code)
resource "aws_lambda_function" "get_rds_data_lambda" {
  function_name = var.lambda_function_name
  role          = var.lambda_exec_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")

  # Add AWS Pandas Layer
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python38:25"]

  environment {
    variables = {
      RDS_HOST     = replace(var.rds_endpoint, ":3306", "")  # Strip the port from the endpoint
      RDS_PORT     = "3306"  # Explicitly set the port number
      RDS_USER     = var.db_username
      RDS_PASSWORD = var.db_password
      RDS_DB_NAME  = var.db_name
    }
  }

  tags = {
    Name      = "get_rds_data_lambda"
    Terraform = "TRUE"
  }
}
