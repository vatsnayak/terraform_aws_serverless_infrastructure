variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_exec_role_arn" {
  description = "ARN of the Lambda execution role"
  type        = string
}

variable "lambda_memory_size" {
  description = "Amount of memory for Lambda"
  type        = number
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function"
  type        = number
}

variable "db_username" {
  description = "RDS username"
  type        = string
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "rds_endpoint" {
  description = "RDS endpoint"
  type        = string
}