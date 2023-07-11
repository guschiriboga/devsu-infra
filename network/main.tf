data "aws_availability_zones" "available_zones" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_info.vpc
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = local.subnet_count
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, local.subnet_newbits, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count = local.subnet_count
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, local.subnet_newbits, local.subnet_count + count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  tags = {
    Name = "${var.project_name}-private-subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "public_subnet_route_table_asso" {
  count = local.subnet_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_subnet_route_table.id
}