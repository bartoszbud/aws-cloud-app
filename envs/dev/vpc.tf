module "vpc" {
  source      = "../../modules/vpc"
  environment = var.environment
  description = "${var.environment} VPC"
  cidr_block  = "10.0.0.0/16"

  private_subnets = {
    "${var.environment}-private-subnet-01" = {
      cidr                    = "10.0.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = false
    },
    "${var.environment}-private-subnet-02" = {
      cidr                    = "10.0.2.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = false
    }
  }

  public_subnets = {
    "${var.environment}-public-subnet-01" = {
      cidr                    = "10.0.3.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
    },
    "${var.environment}-public-subnet-02" = {
      cidr                    = "10.0.4.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = true
    }
  }
}