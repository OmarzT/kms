resource "aws_kms_key" "backupvault" {
  count                   = var.enable_backupvault_key ? 1 : 0
  description             = "KMS key for backupvault"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = false
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = data.aws_iam_policy_document.backupvault[count.index].json
}

resource "aws_kms_alias" "backupvault" {
  count         = var.enable_backupvault_key ? 1 : 0
  name          = "alias/backupvault"
  target_key_id = join("", aws_kms_key.backupvault.*.id)
}

data "aws_iam_policy_document" "backupvault" {
  count         = var.enable_backupvault_key ? 1 : 0  
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    resources = ["*"]
    actions = [ "kms:*", ]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
  }
  statement {
    sid       = "Allow access from Backup account to copy backups"
    effect    = "Allow"
    actions   = [ "kms:CreateGrant",
                  "kms:Decrypt",
                  "kms:GenerateDataKey*",
                  "kms:DescribeKey"
                ]
    resources = ["*"]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = formatlist("arn:aws:iam::%s:root", var.backup_account_id)
    }    
  }
}
