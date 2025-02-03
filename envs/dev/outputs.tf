output "instance_ips" {
  description = "The internal IP addresses of the created instances"
  value       = module.ec2.instance_ips
}
output "instance_public_ips" {
  description = "The public IP addresses of the created instances"
  value       = module.ec2.instance_public_ips
}
output "instance_names" {
  description = "The names of the created instances"
  value       = module.ec2.instance_names
}

output "lb_dns_name" {
  description = "DNS of the load balancer"
  value       = module.lb.lb_dns_name
}