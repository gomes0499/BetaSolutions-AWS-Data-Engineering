resource "aws_db_instance" "default" {
  identifier                  = var.db_instance_identifier
  engine                      = var.db_engine
  engine_version              = var.engine_version
  instance_class              = var.db_instance_class
  username                    = var.db_username
  password                    = var.db_password
  allocated_storage           = var.allocated_storage
  storage_encrypted           = var.storage_encrypted
  vpc_security_group_ids      = var.vpc_security_group_ids
  db_subnet_group_name        = var.subnet_group_name
  multi_az                    = var.multi_az
  publicly_accessible         = true
  apply_immediately           = true
  skip_final_snapshot         = true
  deletion_protection         = false
  backup_retention_period     = 7
  maintenance_window          = "Mon:00:00-Mon:03:00"
  backup_window               = "03:00-06:00"

  tags = {
    Terraform   = "true"
    Environment = "datalake"
  }
}
