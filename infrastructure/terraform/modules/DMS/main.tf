resource "aws_dms_replication_instance" "this" {
  replication_instance_id     = var.replication_instance_identifier
  replication_instance_class  = var.replication_instance_class
  allocated_storage           = var.allocated_storage_dms
  replication_subnet_group_id = aws_dms_replication_subnet_group.dms_subnet_group.id
}

resource "aws_dms_endpoint" "source" {
  endpoint_id   = "rds-source-endpoint"
  endpoint_type = "source"
  engine_name   = "postgres"
  username      = var.rds_username
  password      = var.rds_password
  server_name   = var.rds_endpoint
  port          = 5432
}

resource "aws_dms_endpoint" "destination" {
  endpoint_id   = "s3-destination-endpoint"
  endpoint_type = "target"
  engine_name   = "s3"


  s3_settings {
    bucket_name             = var.s3_destination_bucket_arn
    service_access_role_arn = var.service_access_role_arn
    bucket_folder           = "raw"
  }
}

resource "aws_dms_replication_subnet_group" "dms_subnet_group" {
  replication_subnet_group_id          = "dms-subnet-group"
  replication_subnet_group_description = "DMS Subnet Group"
  subnet_ids                           = var.subnet_ids
}
