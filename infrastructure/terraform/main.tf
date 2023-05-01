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
  subnet_ids             = module.vpc_resources.resources_subnet_ids
  vpc_security_group_ids = [module.vpc_resources.resources_sg_id]
  allocated_storage      = var.allocated_storage
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
  vpc_security_group_ids = [module.vpc_resources.resources_sg_id]
  subnet_ids             = module.vpc_resources.resources_subnet_ids
}

# DMS
module "dms" {
  source                          = "./modules/DMS"
  replication_instance_identifier = var.replication_instance_identifier
  replication_instance_class      = var.replication_instance_class
  allocated_storage_dms           = var.allocated_storage_dms
  subnet_ids                      = module.vpc_resources.resources_subnet_ids
  rds_username                    = var.rds_username
  rds_password                    = var.rds_password
  rds_endpoint                    = module.rds.rds_endpoint
  s3_destination_bucket_arn       = var.bucket_name
  service_access_role_arn         = var.service_access_role_arn
  dms_vpc_role_arn                = module.dms.dms_vpc_management_role_arn
  s3_bucket_arn                   = module.datalake_s3.bucket_arn
  database_name                   = var.database_name
}

# Glue
module "glue" {
  source = "./modules/Glue"

  glue_job_name           = var.glue_job_name
  glue_service_role_arn   = var.glue_service_role_arn
  glue_script_name        = var.glue_script_name
  glue_scripts_bucket_arn = module.datalake_s3.glue_scripts_bucket_arn
}

# Airflow
# module "airflow" {
#   source = "./modules/Airflow"

#   airflow_environment_name   = var.airflow_environment_name
#   airflow_role_arn           = var.airflow_role_arn
#   security_group_ids         = [module.vpc_resources.resources_sg_id]
#   subnet_ids                 = module.vpc_resources.resources_subnet_ids
#   airflow_scripts_bucket_arn = module.datalake_s3.airflow_scripts_bucket_arn
# }

# SNS
module "sns" {
  source = "./modules/SNS"
}

# CloudWatch
module "cloudwatch" {
  source        = "./modules/CloudWatch"
  glue_job_name = var.glue_job_name
  sns_topic_arn = module.sns.sns_topic_arn
}

# VPC
module "vpc" {
  source               = "./modules/VPC"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}


module "vpc_resources" {
  source                 = "./modules/vpc_resources"
  resources_vpc_name     = var.resources_vpc_name
  resources_vpc_cidr     = var.resources_vpc_cidr
  resources_subnet_cidrs = var.resources_subnet_cidrs
  resources_subnet_azs   = var.resources_subnet_azs
}

# EC2
module "ec2" {
  source                    = "./modules/EC2"
  public_instance_ami       = var.public_instance_ami
  public_instance_type      = var.public_instance_type
  private_instance_ami      = var.private_instance_ami
  private_instance_type     = var.private_instance_type
  key_name                  = var.key_name
  public_subnet_id          = module.vpc.public_subnet_ids[0]
  private_subnet_id         = module.vpc.private_subnet_ids[0]
  public_security_group_id  = module.vpc.public_security_group_id
  private_security_group_id = module.vpc.private_security_group_id
}

# Api Gateway
# module "api_gateway" {
#   source = "./modules/ApiGateway"

#   api_name                = var.api_name
#   api_description         = var.api_description
#   integration_description = var.integration_description
#   ec2_web_server_url      = "http://${module.ec2.web_server_public_dns}:port" # Replace "port" with the port of application
# }

# Cognito
module "cognito" {
  source                = "./modules/Cognito"
  user_pool_name        = var.user_pool_name
  user_pool_client_name = var.user_pool_client_name
  user_pool_domain      = var.user_pool_domain
}
