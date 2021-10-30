data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "current" {}

locals {
  dest_list_arns   = formatlist("arn:aws:iam::%s:root", var.backup_account_id)
  source_list_arns = formatlist("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id)
  dest_list        = concat(local.dest_list_arns)
  src_list         = concat(local.source_list_arns)
}
