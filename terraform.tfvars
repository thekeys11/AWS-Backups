aws_region = ""
tags       = { Environment = "", ApplicationID = "", Owner = "", Origin = "Terraform" }

### Enviroment Taxonomy ###
local_tag_cloud = ""
local_tag_reg   = ""
local_tag_ou    = ""
local_tag_pro   = ""
local_tag_env   = ""
vpc_id          = ""

### Module Backups ###
use_selection_tag         = [true, true]
key                       = ["info:backup_RDS", "info:backup_EC2"]
value                     = ["true", "true"]
backup_resource           = []
backup_vault_name         = ["RDS", "EC2"]
backup_plan_name          = ["RDS", "EC2"]
selection_name            = ["backup_resources", "backup_resources"]
kms_backup                = "xxxxxx"
backup_selection_role_arn = "arn:aws:iam::xxx:role/xxx-AWS-BACKUP-ROLE"
rules = [
  {
    name                     = "diario"
    schedule                 = "cron(00 20 * * ? *)"
    start_window             = 60
    completion_window        = 180
    delete_after             = 8
    enable_continuous_backup = true
  },
  {
    name                     = "semanal"
    schedule                 = "cron(0 12 ? * sat *)"
    start_window             = 60
    completion_window        = 180
    delete_after             = 30
    enable_continuous_backup = false
  },
  {
    name                     = "mensual"
    schedule                 = "cron(0 12 1 * ? *)"
    start_window             = 60
    completion_window        = 180
    delete_after             = 182
    enable_continuous_backup = false
  }
]
