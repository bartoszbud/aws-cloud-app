module "terraform_state_bucket" {
  source      = "../../modules/terraform_state_bucket"
  environment = var.environment
  table_name  = var.table_name
}

module "vpc" {
  source      = "../../modules/vpc"
  environment = var.environment
  description = "${var.environment} VPC"
  cidr_block  = "10.0.0.0/16"

  subnets = {
    "dev-subnet-01" = {
      cidr                    = "10.0.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = false
    },
    "dev-subnet-02" = {
      cidr                    = "10.0.2.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = false
    }
  }
}