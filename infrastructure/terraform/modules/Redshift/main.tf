resource "aws_redshift_cluster" "default" {
  cluster_identifier         = var.cluster_identifier
  node_type                  = var.node_type
  number_of_nodes            = var.number_of_nodes
  master_username            = var.master_username
  master_password            = var.master_password
  vpc_security_group_ids     = var.vpc_security_group_ids
  cluster_subnet_group_name  = var.subnet_group_name
}
