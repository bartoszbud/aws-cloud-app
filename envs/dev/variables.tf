variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Type of environment"
  type        = string
}

variable "table_name" {
  description = "Lock table name"
  type = string  
}