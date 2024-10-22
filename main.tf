# Fetch the default VPC (not used for Lambda, only for security groups)
data "aws_vpc" "default" {
  default = true
}

# Security Group for RDS - Allow inbound access from Lambda and MySQL Workbench
resource "aws_security_group" "rds_sg" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow all IPs to access RDS (for testing, restrict to specific IP for security in production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "rds_sg"
    Terraform = "TRUE"
  }
}

# IAM module for Lambda roles
module "iam" {
  source = "./modules/iam"
}

# Lambda function 1: api_lambda (Triggered by EventBridge, no code in Terraform)
module "api_lambda" {
  source               = "./modules/api_lambda" # Separate module folder for api_lambda
  lambda_function_name = "api_lambda"           # Pass name for api_lambda function
  lambda_exec_role_arn = module.iam.lambda_exec_role_arn
  lambda_memory_size   = var.lambda_memory_size
  lambda_timeout       = var.lambda_timeout
}


# Lambda function 2: get_rds_data_lambda (Triggered by API Gateway)
module "get_rds_data_lambda" {
  source               = "./modules/get_rds_data_lambda" # Separate module folder for get_rds_data_lambda
  lambda_function_name = "get_rds_data_lambda"           # Pass name for get_rds_data_lambda function
  lambda_exec_role_arn = module.iam.lambda_exec_role_arn
  lambda_memory_size   = var.lambda_memory_size
  lambda_timeout       = var.lambda_timeout

  db_username  = var.db_username
  db_password  = var.db_password
  db_name      = var.db_name
  rds_endpoint = module.rds.rds_endpoint
}



# RDS module: Ensure public accessibility and allow MySQL Workbench
module "rds" {
  source                = "./modules/rds"
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_instance_class     = var.db_instance_class
  subnet_ids            = [data.aws_subnet.default_public_subnet_1.id, data.aws_subnet.default_public_subnet_2.id] # Add subnet IDs
  rds_security_group_id = aws_security_group.rds_sg.id
  publicly_accessible   = true # Ensure RDS is publicly accessible
}



# API Gateway for get_rds_data_lambda (GET /lambda)
module "api_gateway" {
  source              = "./modules/api_gateway"
  lambda_function_arn = module.get_rds_data_lambda.get_rds_data_lambda_arn # Correctly reference get_rds_data_lambda
  aws_region          = var.aws_region
}

module "event_scheduler" {
  source              = "./modules/event_scheduler"
  lambda_arn          = module.api_lambda.api_lambda_arn # Correctly reference api_lambda
  schedule_expression = var.schedule_expression
}

# Security Group for Lambda - Allow outbound access (if needed for external APIs or services)
resource "aws_security_group" "lambda_sg" {
  vpc_id = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic for Lambda to access the internet
  }

  tags = {
    Name      = "lambda_sg"
    Terraform = "TRUE"
  }
}

data "aws_subnet" "default_public_subnet_1" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  availability_zone = "us-east-1a" # Adjust to your region
}

data "aws_subnet" "default_public_subnet_2" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }

  availability_zone = "us-east-1b" # Adjust to your region
}