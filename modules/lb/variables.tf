variable "environment" {
  description = "Type of environment"
  type        = string
  default     = "dev"
}

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

/*variable "ec2_instance_ips" {
  description = "List of EC2 instance IPs to attach to the load balancer target group"
  type        = list(string)
}*/