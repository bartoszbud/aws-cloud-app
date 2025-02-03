//provider "aws" {}

module "mysql_db" {
  source                 = "../../modules/db"
  environment            = var.environment
  name                   = var.name
  region                 = var.region
  public_subnets         = var.pub_subnets
  db_instance_identifier = var.db_instance_identifier
  db_username            = var.db_username
  db_password            = var.db_password
  allowed_ips            = var.allowed_ips

  depends_on = [ module.ec2 ]
}