import json
import logging
import sys
import boto3
import base64

def decrypt(encrypted_value : str, kms_key : str, region : str) -> str:
    """
    Decrypts the given encrypted value using the given KMS key.
    """
    kms = boto3.client('kms', region_name=region)

    plaintext = kms.decrypt(
        CiphertextBlob=bytes(base64.b64decode(encrypted_value)),
        KeyId=kms_key
    )
    return plaintext["Plaintext"]

if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG)
    input = json.loads(sys.stdin.read())
    logging.debug(input)
    decrypted_value = decrypt(input['encrypted_value'], input['kms_key'] ,input['kms_key_region'])
    print(json.dumps({'decrypted_value': decrypted_value.decode('UTF-8')}))
