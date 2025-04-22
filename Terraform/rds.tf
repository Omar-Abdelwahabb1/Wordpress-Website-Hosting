resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "wordpress-db-subnet-group"
  subnet_ids =  [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name = "wordpress-db-subnet-group"
  }
}
# RDS
resource "aws_db_instance" "wordpress_db" {
  identifier              = "wordpress-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "omar"
  password                = "omar1234"
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = false # money

  tags = {
    Name = "wordpress-db"
  }
}
