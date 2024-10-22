# Common variables for the infrastructure
variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "anurag"
}

# variable "db_password" {
#   default = "anurag@1234"
# }

variable "db_password" {
  description = "The password for the RDS instance"
  default     = "Anurag1234!" # Ensure it contains only valid characters
}

variable "db_instance_class" {
  default = "db.t3.micro" # Free tier eligible instance class
}

variable "lambda_memory_size" {
  default = 1024
}

variable "lambda_timeout" {
  default = 500
}

variable "schedule_expression" {
  default = "rate(5 minutes)"
}

variable "aws_region" {
  description = "The AWS region where the resources will be deployed"
  default     = "us-east-1" # You can change this to the desired region.
}