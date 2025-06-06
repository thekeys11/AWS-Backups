### Creation Backup Vault ### 
resource "aws_backup_vault" "backup-vault" {
  count       = length(var.backup_vault_name)
  name        = var.backup_vault_name[count.index]
  kms_key_arn = var.kms_backup
  tags = {
    Role = "backup-vault"
  }
}

### Creation Backup Plans and rules ### 
resource "aws_backup_plan" "backup-plan" {
  count = length(aws_backup_vault.backup-vault)
  name  = var.backup_plan_name[count.index]
  dynamic "rule" {
    for_each = var.rules
    content {
      rule_name                = lookup(rule.value, "name", null)
      target_vault_name        = aws_backup_vault.backup-vault[count.index].name
      schedule                 = lookup(rule.value, "schedule", null)
      start_window             = lookup(rule.value, "start_window", null)
      completion_window        = lookup(rule.value, "completion_window", null)
      enable_continuous_backup = lookup(rule.value, "enable_continuous_backup", null)
      recovery_point_tags = {
        Frequency  = lookup(rule.value, "name", null)
        Created_By = "aws-backup"
      }
      lifecycle {
        delete_after       = lookup(rule.value, "delete_after", null)
        cold_storage_after = lookup(rule.value, "cold_storage_after", null)
      }
    }
  }
  lifecycle {
    ignore_changes = [
      rule
    ]
  }
}

resource "aws_backup_selection" "backup-selection" {
  count        = length(aws_backup_plan.backup-plan)
  iam_role_arn = var.backup_selection_role_arn
  name         = var.selection_name[count.index]
  plan_id      = aws_backup_plan.backup-plan[count.index].id

  dynamic "selection_tag" {
    for_each = var.use_selection_tag[count.index] ? [1] : []
    content {
      type  = "STRINGEQUALS"
      key   = var.key[count.index]
      value = var.value[count.index]
    }
  }
  resources = var.use_selection_tag[count.index] ? [] : var.backup_resource[count.index]
}