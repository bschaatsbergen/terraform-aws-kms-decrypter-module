variable "encrypted_value" {
  description = "KMS encrypted value"
  type        = string
}

variable "kms_key" {
  description = "KMS key to decrypt value with"
  type        = string
}

variable "kms_key_region" {
  description = "KMS key region"
  type        = string
}
