variable "cidr_block" {
  description = "CIDR block"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "description" {
  description = "Description of VPC"
  type        = string  
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    cidr                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  })) 
}
