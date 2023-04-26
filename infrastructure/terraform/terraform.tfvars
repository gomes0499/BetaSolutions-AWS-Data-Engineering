# Vars for S3 Module
bucket_name = "wu9-datalake"
region      = "us-east-1"

# Vars for RDS Module
db_instance_identifier = "wu9-rds-instance"
db_engine              = "postgres"
db_username            = "wu9rdsusername"
db_password            = "Wu9rdspassword"
db_instance_class      = "db.t3.micro"
subnet_group_name      = "gomes-public-subnet-1"
vpc_security_group_ids = ["sg-0b2ee550a356a8cb9"]
allocated_storage      = 20
engine_version         = "13.3"
multi_az               = false
storage_encrypted      = true

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
subnet_group_name_dms           = "gomes-public-subnet-1"
rds_username                    = "wu9rdsusername"
rds_password                    = "Wu9rdspassword"
service_access_role_arn         = "arn:aws:iam::222498481656:role/data_engineer_services"