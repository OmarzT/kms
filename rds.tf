resource "aws_kms_key" "rds" {
  count                   = var.enable_rds_key ? 1 : 0
  description             = "KMS key for RDS snapshots"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = false
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = data.template_file.rds[count.index].rendered
}

resource "aws_kms_alias" "rds" {
  count         = var.enable_rds_key ? 1 : 0
  name          = "alias/rds"
  target_key_id = join("", aws_kms_key.rds.*.id)
}

data "template_file" "rds" {
  count    = var.enable_rds_key ? 1 : 0
  template = file("${path.module}/policies/kms_rds_shared.json.tpl")
  vars = {
    backup_account = jsonencode(local.dest_list)
    live_account   = jsonencode(local.src_list)
  }
}


