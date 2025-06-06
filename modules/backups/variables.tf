### Taxonomy ###
variable "aws_region" {
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