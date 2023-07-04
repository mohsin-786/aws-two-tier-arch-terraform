resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}
#INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Int-gateway"
  }
}
###################################
#PUBLIC SUBNET 1
resource "aws_subnet" "pubnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub-subnet[0]
  availability_zone       = var.az[0]
  map_public_ip_on_launch = true
}
#PUBLIC SUBNET 2
resource "aws_subnet" "pubnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub-subnet[1]
  availability_zone       = var.az[1]
  map_public_ip_on_launch = true
}
###################################

#PRIVATE SUBNET 1
resource "aws_subnet" "privnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.priv-subnet[0]
  availability_zone       = var.az[0]
  map_public_ip_on_launch = false
}
#PRIVATE SUBNET 2
resource "aws_subnet" "privnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.priv-subnet[1]
  availability_zone       = var.az[1]
  map_public_ip_on_launch = false
}
#PRIVATE SUBNET 3
resource "aws_subnet" "privnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.priv-subnet[2]
  availability_zone       = var.az[0]
  map_public_ip_on_launch = false
}
#PRIVATE SUBNET 4
resource "aws_subnet" "privnet-4" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.priv-subnet[3]
  availability_zone       = var.az[1]
  map_public_ip_on_launch = false
}
###################################
#ROUTE TABLE FOR PUBLIC ASSOCIATION
resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt-1"
  }
}
#ROUTE TABLE FOR PRIVATE 2 ASSOCIATION
resource "aws_route_table" "rt-priv-1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-1.id
  }
  tags = {
    Name = "rt-private-1"
  }
}
#ROUTE TABLE FOR PRIVATE 1 ASSOCIATION
resource "aws_route_table" "rt-priv-2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-2.id
  }
  tags = {
    Name = "rt-priv-2"
  }
}
###################################
#ROUTE TABLE ASSOCIATION FOR PUBLIC SUBNET 1
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pubnet-1.id
  route_table_id = aws_route_table.rt-pub.id

}
#ROUTE TABLE ASSOCIATION FOR PUBLIC SUBNET 2
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pubnet-2.id
  route_table_id = aws_route_table.rt-pub.id

}
###################################
###################################
#ROUTE TABLE ASSOCIATION FOR PRIVATE SUBNET 1
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.privnet-1.id
  route_table_id = aws_route_table.rt-priv-1.id

}
#ROUTE TABLE ASSOCIATION FOR PRIVATE SUBNET 2
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.privnet-2.id
  route_table_id = aws_route_table.rt-priv-2.id

}
#ROUTE TABLE ASSOCIATION FOR PRIVATE SUBNET 3
resource "aws_route_table_association" "e" {
  subnet_id      = aws_subnet.privnet-3.id
  route_table_id = aws_route_table.rt-priv-1.id

}
#ROUTE TABLE ASSOCIATION FOR PRIVATE SUBNET 4
resource "aws_route_table_association" "f" {
  subnet_id      = aws_subnet.privnet-4.id
  route_table_id = aws_route_table.rt-priv-2.id
 
} 
###################################

###################################
#NAT GATEWAY 1
resource "aws_nat_gateway" "nat-1" {
  subnet_id     = aws_subnet.pubnet-1.id
  allocation_id = aws_eip.eip-1.id
  depends_on    = [aws_internet_gateway.igw]

}
#NAT GATEWAY 2
resource "aws_nat_gateway" "nat-2" {
  subnet_id     = aws_subnet.pubnet-2.id
  allocation_id = aws_eip.eip-2.id
  depends_on    = [aws_internet_gateway.igw]
}
###################################


###################################

