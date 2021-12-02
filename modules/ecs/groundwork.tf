resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC api_desafio_devops"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}
