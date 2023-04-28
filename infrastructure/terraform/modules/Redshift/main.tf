resource "aws_redshift_cluster" "default" {
  cluster_identifier        = var.cluster_identifier
  node_type                 = var.node_type
  number_of_nodes           = var.number_of_nodes
  master_username           = var.master_username
  master_password           = var.master_password
  vpc_security_group_ids    = var.vpc_security_group_ids
  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_group.name
  skip_final_snapshot       = true
}


resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name       = "redshift-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.cluster_identifier
  }
}
