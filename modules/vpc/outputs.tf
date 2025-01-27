output "vpc_name" {
  description = "Name of the VPC"
  value = (aws_vpc.vpc.tags["Name"])
}