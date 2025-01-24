resource "aws_vpc" "systest_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name        = "systest-vpc"
    Environment = "systest"
  }
}

resource "aws_internet_gateway" "systest_igw" {
  vpc_id = aws_vpc.systest_vpc.id

  tags = {
    Name        = "systest-igw"
    Environment = "systest"
  }
}

resource "aws_route_table" "systest_route_table" {
  vpc_id = aws_vpc.systest_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.systest_igw.id
  }

  tags = {
    Name        = "systest-route-table"
    Environment = "systest"
  }
}

resource "aws_subnet" "systest_subnets" {
  count             = 3
  vpc_id            = aws_vpc.systest_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.systest_vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "systest-subnet-${count.index + 1}"
    Environment = "systest"
  }
}

resource "aws_route_table_association" "systest_route_association" {
  count          = 3
  subnet_id      = aws_subnet.systest_subnets[count.index].id
  route_table_id = aws_route_table.systest_route_table.id
}

data "aws_availability_zones" "available" {}



