resource "aws_instance" "public" {
  ami           = var.public_instance_ami
  instance_type = var.public_instance_type
  key_name      = var.key_name

  subnet_id = var.public_subnet_id

  vpc_security_group_ids = [var.public_security_group_id]

  tags = {
    Name = "wu9-public"
  }
}

resource "aws_instance" "private" {
  ami           = var.private_instance_ami
  instance_type = var.private_instance_type
  key_name      = var.key_name

  subnet_id = var.private_subnet_id

  vpc_security_group_ids = [var.private_security_group_id]

  tags = {
    Name = "wu9-private"
  }
}
