module "lb" {
  source        = "../../modules/lb"
  ec2_instances = var.ec2_instances
  depends_on    = [ module.ec2_firewall ]
}