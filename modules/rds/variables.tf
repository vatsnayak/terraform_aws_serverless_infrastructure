variable "db_name" {
  description = "The name of the RDS database"
}

variable "db_username" {
  description = "The master username for the RDS instance"
}

variable "db_password" {
  description = "The master password for the RDS instance"
  sensitive   = true
}

variable "db_instance_class" {
  description = "The RDS instance type (e.g., db.t3.micro for free tier)"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The security group ID for the RDS instance"
}

variable "publicly_accessible" {
  description = "Should the RDS instance be publicly accessible?"
  type        = bool
  default     = false
}