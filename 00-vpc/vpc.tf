module "vpc" {
  # source = "../terraform-aws-vpc"
  source = "git::https://github.com/BhavaniTulimelli7/terraform-vpc.git?ref=main"
  project = var.project
  environment = var.environment
  vpc_cidr = var.vpc_cidr
  common_tags = var.common_tags
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr
  is_peering_required = true
}

resource "aws_db_subnet_group" "expense" {
  name       = "${var.project}-${var.environment}"
  subnet_ids = module.vpc.database_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )
}