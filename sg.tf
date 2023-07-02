#SECURITY GROUP FOR LOAD BALANCER
resource "aws_security_group" "lb-sg" {
  name        = "lb-sg"
  description = "Security group for lb"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "lb-secgrp"
  }
}

#SECURITY GROUP FOR WEBSERVER
resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  description = "Security group for webserver"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    security_groups = [ aws_security_group.lb-sg.id ]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    description     = "SSH"
    security_groups = [aws_security_group.bastion-sg.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    
  }
  tags = {
    Name = "web-secgrp"
  }
}

#DATABASE SECURITY GROUP
resource "aws_security_group" "db-sg" {
  name        = "db-sg-sg"
  description = "Security group for db"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    description     = "MySQL"
    cidr_blocks     = ["10.0.0.0/16"]
    security_groups = [aws_security_group.webserver-sg.id]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "db-secgrp"
  }
}

#BASTION HOST SECURITY GROUP
resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security group for lb"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "bastion-secgrp"
  }
}