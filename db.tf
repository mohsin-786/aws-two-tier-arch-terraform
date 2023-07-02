resource "aws_db_subnet_group" "db-grp" {
  name       = "db-grp"
  subnet_ids = [aws_subnet.privnet-3.id, aws_subnet.privnet-4.id]

  tags = {
    Name = "Database-grp"
  }
}

resource "aws_db_instance" "db-mine" {
  allocated_storage      = 5
  db_name                = "minedb"
  engine                 = "mysql"
  engine_version         = "5.7"
  identifier             = "db-instanced"
  instance_class         = "db.t2.micro"
  username               = "password"
  password               = "password"
  parameter_group_name   = "default.mysql5.7"
  deletion_protection    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db-grp.id
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  publicly_accessible    = false
}