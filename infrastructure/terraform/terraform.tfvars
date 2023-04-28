# Vars for S3 Module
bucket_name = "wu9-datalake"
region      = "us-east-1"

# Vars for RDS Module
db_instance_identifier = "wu9-rds-instance"
db_engine              = "postgres"
db_username            = "wu9rdsusername"
db_password            = "Wu9rdspassword"
db_instance_class      = "db.t3.micro"
vpc_security_group_ids = ["sg-0b2ee550a356a8cb9"]
allocated_storage      = 20
multi_az               = false
storage_encrypted      = true
database_name          = "postgres"

# Vars for Redshift Module
cluster_identifier = "wu9-redshift-cluster"
node_type          = "dc2.large"
number_of_nodes    = 2
master_username    = "wu9rdsusername"
master_password    = "Wu9rdspassword"

# Vars for DMS Module
replication_instance_identifier = "wu9-dms-replication-instance"
replication_instance_class      = "dms.t2.micro"
allocated_storage_dms           = 50
rds_username                    = "wu9rdsusername"
rds_password                    = "Wu9rdspassword"
service_access_role_arn         = "arn:aws:iam::222498481656:role/data_engineer_services"

# Vars for Glue Module
glue_job_name         = "glue-spark-job"
glue_service_role_arn = "arn:aws:iam::222498481656:role/data_engineer_services"
glue_script_name      = "spark-job.py"

# Vars for Airflow Module
airflow_environment_name = "wu9airflow"
airflow_role_arn         = "arn:aws:iam::222498481656:role/data_engineer_services"
security_group_ids       = ["sg-0b2ee550a356a8cb9"]
subnet_ids               = ["subnet-07148675ed10f1f31", "subnet-09e9c4a79d7a0dea1"]

# Vars for VPC Module
vpc_name             = "wu9-vpc"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# Vars for EC2 Module
public_instance_ami   = "ami-02396cdd13e9a1257"
public_instance_type  = "t2.micro"
private_instance_ami  = "ami-02396cdd13e9a1257"
private_instance_type = "t2.micro"
key_name              = "wu9keypair"

# Vars for API Gateway Module
api_name                = "wu9-ml-api"
api_description         = "wu9 ML Model API"
integration_description = "Integration with EC2 web server"

# Vars for Cognito Module
user_pool_name        = "wu9_user_pool_name"
user_pool_client_name = "wu9_user_pool_client_name"
user_pool_domain      = "wu9userpooldomain"

# Vars for vpc_resources Module
resources_vpc_name     = "resources-vpc"
resources_vpc_cidr     = "10.1.0.0/16"
resources_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
resources_subnet_azs   = ["us-east-1a", "us-east-1b"] 
