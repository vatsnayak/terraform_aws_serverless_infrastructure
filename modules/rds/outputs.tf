output "db_endpoint" {
  description = "The endpoint of the RDS MySQL instance"
  value       = aws_db_instance.rds_mysql.endpoint
}