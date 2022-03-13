module "database_password" {
  source          = "github.com/bschaatsbergen/terraform-aws-kms-decrypter-module"
  encrypted_value = "AQICAHik727zqZfJBvOo7aQDkoijs82qoKWaF0soyBA3CNnb7gG8rrL9JUX2lk7EMgw/Hp8qAAAAbjBsBgkqhkiG9w0BBwagXzBdAgEAMFgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQM1Z7qTq5USZOAtV9+AgEQgCvggTlbihGhXGNPHhqtxRSNCLSUXUHgbIk7CmN78Pz2YejHbH5Nym+mvrJ1"
  kms_key         = "alias/example-kms-key"
  kms_key_region  = "eu-central-1"
}

output "database_password" {
  description = "decrypted value of the database_password secret"
  value       = module.database_password.decrypted_value
}
                      