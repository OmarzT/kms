resource "aws_kms_key" "rds" {
  count                   = var.enable_rds_key ? 1 : 0
  description             = "KMS key for RDS snapshots"
  key_usage               = "ENCRYPT_DECRYPT"
  enable_key_rotation     = false
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = data.aws_iam_policy_document.rds[count.index].json
}

resource "aws_kms_alias" "rds" {
  count         = var.enable_rds_key ? 1 : 0
  name          = "alias/rds"
  target_key_id = join("", aws_kms_key.rds.*.id)
}


data "aws_iam_policy_document" "rds" {
  count         = var.enable_rds_key ? 1 : 0  
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
    sid       = "Allow use of the key"
    effect    = "Allow"
    resources = ["*"]
    actions = [ "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey" ]
    principals {
      identifiers = formatlist("arn:aws:iam::%s:root", var.backup_account_id)
      type        = "AWS"
    }
  }  
  statement {
    sid       = "Allow attachment of persistent resources"
    effect    = "Allow"
    resources = ["*"]    
    actions   = [ "kms:CreateGrant",
                  "kms:ListGrants",
                  "kms:RevokeGrant",
                  "rds:RemoveTagsFromResource" ]
    principals {
      identifiers = formatlist("arn:aws:iam::%s:root", var.backup_account_id)
      type        = "AWS"
    }
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }  
  }
}