resource "aws_vpc" "resources_vpc" {
  cidr_block = var.resources_vpc_cidr

  tags = {
    Name = "${var.resources_vpc_name}-vpc"
  }
}

resource "aws_subnet" "resources" {
  count = length(var.resources_subnet_cidrs)

  cidr_block = var.resources_subnet_cidrs[count.index]
  vpc_id     = aws_vpc.resources_vpc.id

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
}
