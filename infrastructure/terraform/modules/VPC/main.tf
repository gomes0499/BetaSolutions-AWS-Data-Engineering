resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  cidr_block = var.public_subnet_cidrs[count.index]
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  cidr_block = var.private_subnet_cidrs[count.index]
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}

resource "aws_security_group" "public_instance" {
  name        = "public-instance"
  description = "Security group for the public instance"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "-public-instance"
  }
}

resource "aws_security_group" "private_instance" {
  name        = "private-instance"
  description = "Security group for the private instance"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-instance"
  }
}

resource "aws_security_group_rule" "public_allow_private" {
  security_group_id = aws_security_group.public_instance.id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = var.private_subnet_cidrs
}

resource "aws_security_group_rule" "private_allow_public" {
  security_group_id = aws_security_group.private_instance.id

  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = var.public_subnet_cidrs
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-vpc-internet-gateway"
  }
}
