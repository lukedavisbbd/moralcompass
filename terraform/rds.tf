resource "aws_db_subnet_group" "mc_db_subnet_group" {
  name        = "mc-db-subnet-group"
  subnet_ids  = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  description = "Subnet group for the PostgreSQL RDS instance"
}

resource "aws_db_instance" "mc_db_instance" {
  identifier             = "mc-db"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = var.rds_db_name
  username               = var.rds_db_username
  password               = var.rds_db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.mc_db_subnet_group.name
  multi_az               = false
  publicly_accessible    = true
  skip_final_snapshot    = true
}

