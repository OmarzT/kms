{
  "Version": "2012-10-17",
  "Id": "backup-vault-policy",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": ${live_account}
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow access from AWS Organizations accounts to copy backups",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:CreateGrant",
        "kms:Decrypt",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:PrincipalOrgID": ${awsorgid}
        }
      }
    }
  ]
}