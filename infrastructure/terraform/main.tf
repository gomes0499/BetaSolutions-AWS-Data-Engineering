# S3
module "datalake_s3" {
  source = "./modules/S3"

  bucket_name = var.bucket_name
  region      = var.region
}

# RDS
module "rds" {
  source                 = "./modules/RDS"
  db_instance_identifier = var.db_instance_identifier
  db_engine              = var.db_engine
  db_username            = var.db_username
  db_password            = var.db_password
  db_instance_class      = var.db_instance_class
  subnet_group_name      = var.subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  allocated_storage      = var.allocated_storage
  engine_version         = var.db_engine
  multi_az               = var.multi_az
  storage_encrypted      = var.storage_encrypted
}

# Redshift
module "redshift" {
  source                 = "./modules/Redshift"
  cluster_identifier     = var.cluster_identifier
  node_type              = var.node_type
  number_of_nodes        = var.number_of_nodes
  master_username        = var.master_username
  master_password        = var.master_password
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_group_name      = var.subnet_group_name
}

# DMS
module "dms" {
  source                            = "./modules/DMS"
  replication_instance_identifier   = var.replication_instance_identifier
  replication_instance_class        = var.replication_instance_class
  allocated_storage_dms             = var.allocated_storage
  subnet_group_name_dms             = var.subnet_group_name
  rds_username                      = var.rds_username
  rds_password                      = var.rds_password
  rds_endpoint                      = module.rds.rds_endpoint
  s3_destination_bucket_arn         = module.datalake_s3.bucket_arn
  service_access_role_arn           = var.service_access_role_arn
}
