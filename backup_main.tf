resource "aws_kms_key" "backupvault_main" {
  count                   = var.enable_backupvault_main_key ? 1 : 0
  description             = "KMS key for backupvault"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = false
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = data.template_file.backupvault_main[count.index].rendered
}

resource "aws_kms_alias" "backupvault_main" {
  count         = var.enable_backupvault_main_key ? 1 : 0
  name          = "alias/backupvault"
  target_key_id = join("", aws_kms_key.backupvault_main.*.id)
}

data "template_file" "backupvault_main" {
  count    = var.enable_backupvault_main_key ? 1 : 0
  template = file("${path.module}/policies/kms_backupvault_main.json.tpl")
  vars = {
    awsorgid     = jsonencode(data.aws_organizations_organization.current.id)
    live_account = jsonencode(local.src_list)
  }
}


