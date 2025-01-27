module "vpc" {
  source      = "../../modules/vpc"
  name        = var.environment
  environment = var.environment
  description = "${var.environment} VPC"
  cidr_block  = "10.0.0.0/16"

  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
}