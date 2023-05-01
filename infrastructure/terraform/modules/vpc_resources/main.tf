resource "aws_vpc" "resources_vpc" {
  cidr_block = var.resources_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.resources_vpc_name}-vpc"
  }
}

resource "aws_subnet" "resources" {
  count = length(var.resources_subnet_cidrs)

  cidr_block = var.resources_subnet_cidrs[count.index]
  vpc_id     = aws_vpc.resources_vpc.id
  availability_zone = var.resources_subnet_azs[count.index]

  tags = {
    Name = "${var.resources_vpc_name}-resources-${count.index + 1}"
  }
}

resource "aws_security_group" "resources_sg" {
  name        = "resources-security-group"
  description = "Security group for the RDS, DMS, Redshift, and Airflow resources"
  vpc_id      = aws_vpc.resources_vpc.id

  tags = {
    Name = "resources-security-group"
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_internet_gateway" "resources_igw" {
  vpc_id = aws_vpc.resources_vpc.id

  tags = {
    Name = "${var.resources_vpc_name}-igw"
  }
}

resource "aws_route_table" "resources_public_rt" {
  vpc_id = aws_vpc.resources_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.resources_igw.id
  }

  tags = {
    Name = "${var.resources_vpc_name}-public-rt"
  }
}

resource "aws_route_table_association" "resources_public_rta" {
  count          = length(var.resources_subnet_cidrs)
  subnet_id      = aws_subnet.resources[count.index].id
  route_table_id = aws_route_table.resources_public_rt.id
}
