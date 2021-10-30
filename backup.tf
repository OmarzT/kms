resource "aws_kms_key" "backupvault" {
  count                   = var.enable_backupvault_key ? 1 : 0
  description             = "KMS key for backupvault"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = false
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = data.template_file.backupvault[count.index].rendered
}

resource "aws_kms_alias" "backupvault" {
  count         = var.enable_backupvault_key ? 1 : 0
  name          = "alias/backupvault"
  target_key_id = join("", aws_kms_key.backupvault.*.id)
}

data "template_file" "backupvault" {
  count    = var.enable_backupvault_key ? 1 : 0
  template = file("${path.module}/policies/kms_backupvault_shared.json.tpl")
  vars = {
    backup_account = jsonencode(local.dest_list)
    live_account   = jsonencode(local.src_list)
  }
}


