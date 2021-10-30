output "rds_key_arn" {
  value       = join("", aws_kms_key.rds.*.arn)
  description = "Key ARN"
}

output "rds_key_id" {
  value       = join("", aws_kms_key.rds.*.key_id)
  description = "Key ID"
}

output "rds_alias_arn" {
  value       = join("", aws_kms_alias.rds.*.arn)
  description = "Alias ARN"
}

output "rds_alias_name" {
  value       = join("", aws_kms_alias.rds.*.name)
  description = "Alias name"
}

output "backupvault_key_arn" {
  value       = join("", aws_kms_key.backupvault.*.arn)
  description = "Key ARN"
}

output "backupvault_key_id" {
  value       = join("", aws_kms_key.backupvault.*.key_id)
  description = "Key ID"
}

output "backupvault_alias_arn" {
  value       = join("", aws_kms_alias.backupvault.*.arn)
  description = "Alias ARN"
}

output "backupvault_alias_name" {
  value       = join("", aws_kms_alias.backupvault.*.name)
  description = "Alias name"
}

output "backupvault_main_key_arn" {
  value       = join("", aws_kms_key.backupvault_main.*.arn)
  description = "Key ARN"
}

output "backupvault_main_key_id" {
  value       = join("", aws_kms_key.backupvault_main.*.key_id)
  description = "Key ID"
}

output "backupvault_main_alias_arn" {
  value       = join("", aws_kms_alias.backupvault_main.*.arn)
  description = "Alias ARN"
}

output "bbackupvault_main_alias_name" {
  value       = join("", aws_kms_alias.backupvault_main.*.name)
  description = "Alias name"
}
