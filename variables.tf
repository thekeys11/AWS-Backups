### Locals Variables ###
variable "local_tag_cloud" {
  type = string
}
variable "local_tag_reg" {
  type = string
}
variable "local_tag_ou" {
  type = string
}
variable "local_tag_pro" {
  type = string
}
variable "local_tag_env" {
  type = string
}

### Global Variables ###
variable "aws_region" {
  type = string
}
variable "tags" {
  type = map(any)
}
variable "vpc_id" {
  type = string
}

### Variables Backups ###
variable "kms_backup" {
  type = string
}
variable "backup_vault_name" {
  type = list(string)
}
variable "key" {
  type = list(string)
}
variable "value" {
  type = list(string)
}
variable "backup_plan_name" {
  type = list(string)
}
variable "rules" {}
variable "backup_selection_role_arn" {
  type = string
}
variable "use_selection_tag" {
  type = list(bool)
}
variable "backup_resource" {
  type = list(list(string))
}
variable "selection_name" {
  type = list(string)
}