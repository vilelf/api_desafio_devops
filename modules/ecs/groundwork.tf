resource "aws_subnet" "subnet_a" {
  availability_zone = format("%sa", var.aws_region)
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.main.id
  
  depends_on = [aws_internet_gateway.main]
}

resource "aws_subnet" "subnet_b" {
  availability_zone = format("%sb", var.aws_region)
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.main.id

  depends_on = [aws_internet_gateway.main]
}

resource "aws_subnet" "subnet_c" {
  availability_zone = format("%sc", var.aws_region)
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.main.id

  depends_on = [aws_internet_gateway.main]
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}