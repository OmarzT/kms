# kms

roast dinner

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [template_file.kms-rds](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_account_id"></a> [backup\_account\_id](#input\_backup\_account\_id) | trip-domain-backup-prd account | `string` | `"188485717084"` | no |
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource | `number` | `10` | no |
| <a name="input_enable_rds_key"></a> [enable\_rds\_key](#input\_enable\_rds\_key) | to be or not to be | `bool` | `false` | no |
| <a name="input_enable_s3_key"></a> [enable\_s3\_key](#input\_enable\_s3\_key) | to be or not to be | `bool` | `false` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. | `string` | `"ENCRYPT_DECRYPT"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rds_alias_arn"></a> [rds\_alias\_arn](#output\_rds\_alias\_arn) | Alias ARN |
| <a name="output_rds_alias_name"></a> [rds\_alias\_name](#output\_rds\_alias\_name) | Alias name |
| <a name="output_rds_key_arn"></a> [rds\_key\_arn](#output\_rds\_key\_arn) | Key ARN |
| <a name="output_rds_key_id"></a> [rds\_key\_id](#output\_rds\_key\_id) | Key ID |
