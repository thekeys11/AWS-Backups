module "backups" {
  source                    = "./modules/backups"
  aws_region                = var.aws_region
  backup_vault_name         = var.backup_vault_name
  rules                     = var.rules
  backup_selection_role_arn = var.backup_selection_role_arn
  backup_resource           = var.backup_resource
  key                       = var.key
  use_selection_tag         = var.use_selection_tag
  value                     = var.value
  backup_plan_name          = var.backup_plan_name
  selection_name            = var.selection_name
  kms_backup                = var.kms_backup
}