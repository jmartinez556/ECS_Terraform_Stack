resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Justins-vpc"
  }
}
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Justins-ig"
  }
}
resource "aws_subnet" "public-1" {
  availability_zone = var.availability_zone1
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_1_cidr_block

  tags = {
    Name = "Justins-public_subnet-1"
  }
}
resource "aws_subnet" "public-2" {
  availability_zone = var.availability_zone2
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_2_cidr_block

  tags = {
    Name = "Justins-public_subnet-2"
  }
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "Justins-public-rt"
  }
}
resource "aws_route_table_association" "rta-public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "rta-public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_subnet" "private-1" {
  availability_zone = var.availability_zone1
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr_block

  tags = {
    Name = "Justins-private_subnet-1"
  }
}
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "Justins-private-rt"
  }
}
resource "aws_route_table_association" "rta-private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-1.id
  tags = {
    Name = "Justins-nat-gateway"
  }
}