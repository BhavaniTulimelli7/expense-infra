module "db" {
  source = "terraform-aws-modules/rds/aws"
  identifier = local.resource_name #expense-dev

  engine            = "mysql"
  engine_version    = "8.0.40"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = "transactions" # AWS will create this schema automatically
  username = "root"
  port     = "3306"
  manage_master_user_password = false

  vpc_security_group_ids = [local.mysql_sg_id]

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = data.aws_ssm_parameter.database_subnet_ids

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false
  skip_final_snapshot = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]

  tags = merge(
    var.common_tags,
    {
        Name = local.resource_name
    }
  )
}

resource "aws_route53_record" "www-dev" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 5
  records = [module.db.db_instance_address]
  allow_overwrite = true
}

# resource "aws_db_subnet_group" "this" {
#   name       = "${var.project_name}-${var.environment}-db-subnet-group"
#   subnet_ids = var.database_subnet_ids

#   tags = {
#     Name        = "${var.project_name}-${var.environment}-db-subnet-group"
#     Environment = var.environment
#     Project     = var.project_name
#   }
# }
