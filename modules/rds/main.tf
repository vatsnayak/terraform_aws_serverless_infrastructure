# Define the DB Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.db_name}-subnet-group"  # Use 'name' instead of 'db_name'
  subnet_ids = var.subnet_ids

  tags = {
    Name      = "${var.db_name}-subnet-group"
    Terraform = "TRUE"
  }
}

# Create the RDS Instance
# modules/rds/main.tf

resource "aws_db_instance" "rds_mysql" {
  allocated_storage    = 20
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  engine               = "mysql"
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = var.publicly_accessible  # Ensure it's used as a variable
  vpc_security_group_ids = [var.rds_security_group_id]
  skip_final_snapshot  = true
  deletion_protection  = false

  tags = {
    Name      = "${var.db_name}"
    Terraform = "TRUE"
  }
}


# Output the RDS Endpoint
output "rds_endpoint" {
  description = "RDS MySQL instance endpoint"
  value       = aws_db_instance.rds_mysql.endpoint
}