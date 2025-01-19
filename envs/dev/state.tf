module "terraform_state_bucket" {
  source      = "../../modules/tf-state"
  environment = var.environment
  table_name  = var.table_name
}