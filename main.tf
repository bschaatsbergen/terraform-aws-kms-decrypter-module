data "external" "default" {
  program = ["python3", "${path.module}/src/main.py"]

  query = {
    encrypted_value = var.encrypted_value
    kms_key         = var.kms_key
    kms_key_region  = var.kms_key_region
  }
}
