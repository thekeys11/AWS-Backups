provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "info:applicationID"  = var.local_tag_pro
      "info:env"            = var.local_tag_env
      "business:owner"      = var.local_tag_ou
    }
  }
}