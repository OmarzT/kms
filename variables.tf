variable "enable_rds_key" {
  description = "to be or not to be"
  default     = false
}

variable "enable_s3_key" {
  description = "to be or not to be"
  default     = false
}

variable "enable_backupvault_key" {
  description = "CMK  KMS key for aws backupvault"
  default     = false
}

variable "enable_backupvault_main_key" {
  description = "CMK  KMS key for aws backupvault"
  default     = false
}

variable "backup_account_id" {
  description = "trip-domain-backup-prd account"
  default     = "662733315436"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`."
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`."
}
