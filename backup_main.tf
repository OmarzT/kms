resource "aws_kms_key" "backupvault_main" {
  count                   = var.enable_backupvault_main_key ? 1 : 0
  description             = "KMS key for backupvault"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = false
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = data.aws_iam_policy_document.backupvault_main[count.index].json
}

resource "aws_kms_alias" "backupvault_main" {
  count         = var.enable_backupvault_main_key ? 1 : 0
  name          = "alias/backupvault"
  target_key_id = join("", aws_kms_key.backupvault_main.*.id)
}

data "aws_iam_policy_document" "backupvault_main" {
  count = var.enable_backupvault_main_key ? 1 : 0
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:*", ]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
  }
  statement {
    sid    = "Allow access from Backup account to copy backups"
    effect = "Allow"
    actions = ["kms:CreateGrant",
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    principals {
      identifiers = "*"
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = [data.aws_organizations_organization.current.id]
    }
  }
}
