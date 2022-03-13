# Terraform AWS KMS secrets module

Module to decrypt AWS KMS secrets. Please note that the decryted secrets are stored in the Terraform state, we encourage you to always treat your Terraform state as a secret and never store it in a public repository.

## Usage

To use this module you're required to have a KMS key that you can use to encrypt/decrypt your secrets with.

We simply declare a module block with the following configuration:

```hcl
module "database_password" {
  source          = "../"
  encrypted_value = "AQICAHik727zqZfJBvOo7aQDkoijs82qoKWaF0soyBA3CNnb7gG339QIJjNdUD7obzUlfMWFAAAAbjBsBgkqhkiG9w0BBwagXzBd"
  kms_key         = "alias/example-kms-key"
  kms_key_region  = "eu-central-1"
}
```

This module outputs a `decrypted_value` that you can use to pass on to your other Terraform code.

```hcl
output "database_password" {
  value = module.database_password.decrypted_value
}
```

`kms_key` can be either an alias, key ID or a full ARN.

The encrypted value is a base64 encoded string that is encrypted with the KMS key, see below for more information on how to encrypt your secrets.

## Setting a encrypted value

To encrypt a value you can use the `aws kms encrypt` function. This function takes a plaintext value and a KMS key ID and returns a base64 encoded ciphertext.

```bash
aws kms encrypt --key-id alias/example-kms-key --plaintext "mysecurepassword" --region eu-central-1 --cli-binary-format raw-in-base64-out
{
    "CiphertextBlob": "AQICAHik727zqZfJBvOo7aQDkoijs82qoKWaF0soyBA3CNnb7gG339QIJjNdUD7obzUlfMWFAAAAbjBsBgkqhkiG9w0BBwagXzBd",
    "KeyId": "arn:aws:kms:eu-central-1:123456789111:key/a-key-id",
    "EncryptionAlgorithm": "SYMMETRIC_DEFAULT"
}
```

Simply copy the `CiphertextBlob` value and paste it into the `encrypted_value` field of the module block.



## Requirements

No requirements.

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
|  [external](#provider_external) | 2.2.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                      | Type        |
| ------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [external_external.default](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name                                                                           | Description                   | Type     | Default | Required |
| ------------------------------------------------------------------------------ | ----------------------------- | -------- | ------- | :------: |
|  [encrypted_value](#input_encrypted_value) | KMS encrypted value           | `string` | n/a     |    yes   |
|  [kms_key](#input_kms_key)                         | KMS key to decrypt value with | `string` | n/a     |    yes   |
|  [kms_key_region](#input_kms_key_region)    | KMS key region                | `string` | n/a     |    yes   |

## Outputs

| Name                                                                             | Description     |
| -------------------------------------------------------------------------------- | --------------- |
|  [decrypted_value](#output_decrypted_value) | Decrypted value |

