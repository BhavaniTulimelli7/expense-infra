locals {
  resource_name = "${var.project_name}-${var.environment}"
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  database_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}
