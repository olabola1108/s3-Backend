resource "aws_vpc" "dev" {
  cidr_block       = "172.32.0.0/16"
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Dev-Vpc"
  }
}

# Create an Internet Gateway for public subnets
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev.id
}

#Create public-subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.dev.id
  count                   = length(var.public_subnet_cidrs)
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_names[count.index]
  }
}

# Create private subnets
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.dev.id
  count                   = length(var.private_subnet_cidrs)
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = var.private_subnet_names[count.index]
  }
}

resource "aws_eip" "dev_eip" {

}

resource "aws_nat_gateway" "dev_natgw" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.dev_eip.id
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.dev.id

  route {
    gateway_id = aws_internet_gateway.dev_igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "public_RT_dev"
  }

}

resource "aws_route_table_association" "publicRTA" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table" "private_RT_dev" {
  vpc_id = aws_vpc.dev.id

  route {
    nat_gateway_id = aws_nat_gateway.dev_natgw.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "Private_RT_dev1"
  }

}

resource "aws_route_table_association" "first_4_subnets_association" {
  count          = 1 # This specifies that we are associating the first 4 subnets
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_RT_dev.id
}

resource "aws_route_table" "private_RT_dev2" {
  vpc_id = aws_vpc.dev.id

  route {
    nat_gateway_id = aws_nat_gateway.dev_natgw.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "Private_RT_dev2"
  }

}

resource "aws_route_table_association" "last_3_subnets_association" {
  count          = length(var.private_subnet_cidrs) - 1 # This specifies that we are associating the last 3 subnets
  subnet_id      = aws_subnet.private[count.index + 1].id
  route_table_id = aws_route_table.private_RT_dev2.id
}
