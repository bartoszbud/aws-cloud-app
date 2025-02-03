#Project variables
variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Type of environment"
  type        = string
}

#State variables
variable "table_name" {
  description = "Lock table name"
  type        = string  
}

#VPC variables
variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    cidr                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    cidr                    = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))
}

#EC2 variables
variable "ec2_instances" {
  description = "Map of EC2 instances to create"
  type = map(object({
    instance_type        = string
    instance_description = optional(string)
    availability_zone    = string
    subnet_name          = string
    subnet_cidr          = string
    ip_host              = number
  }))
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances (for Ubuntu)"
  type        = string
}

variable "ssh_key_name" {
  description = "Admin user SSH key"
  type        = string
  default     = "admin"
}

variable "allow_firewall_rules" {
  description = "Map of allow firewall rules."
  type = map(object({
    protocol         = string
    ports            = optional(list(string))
    priority         = number
    description      = string
    source_ip_ranges = list(string)
  }))
}

#RDS variables
variable "name" {
  description = "IDK"
  type        = string
}

variable "pub_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "db_instance_identifier" {
  description = "The DB instance identifier"
  type        = string
  default     = "public-mysql-db"
}

variable "db_username" {
  description = "Master username for the DB instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the DB instance"
  type        = string
}

variable "allowed_ips" {
  description = "List of allowed CIDR blocks for MySQL access"
  type        = list(string)
}