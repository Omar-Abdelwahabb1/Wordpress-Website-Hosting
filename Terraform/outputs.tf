output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.wordpress_alb.dns_name
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint for database connection"
  value       = aws_db_instance.wordpress_db.endpoint
}
