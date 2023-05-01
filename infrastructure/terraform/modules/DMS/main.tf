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
  database_name = var.database_name
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

resource "aws_iam_role" "dms_vpc_management_role" {
  name = "dms-vpc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "dms.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dms_vpc_management_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  role       = aws_iam_role.dms_vpc_management_role.name
}

resource "aws_iam_role" "dms_s3_access_role" {
  name = "dms-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "dms.amazonaws.com"
        }
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "dms_s3_access_role_cloudwatch_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
  role       = aws_iam_role.dms_s3_access_role.name
}

resource "aws_iam_policy" "dms_s3_access_inline_policy" {
  name        = "dms-s3-access-inline-policy"
  description = "Inline policy to grant DMS access to the specified S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
        ]
        Effect   = "Allow"
        Resource = var.s3_bucket_arn
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Effect   = "Allow"
        Resource = "${var.s3_bucket_arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dms_s3_access_inline_policy_attachment" {
  policy_arn = aws_iam_policy.dms_s3_access_inline_policy.arn
  role       = aws_iam_role.dms_s3_access_role.name
}
