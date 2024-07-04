# python/vault_secrets.py
import hvac

def main():
    client = hvac.Client(url='http://localhost:8200', token='myroot')

    # Write a secret
    client.secrets.kv.v2.create_or_update_secret(
        path='mysecret',
        secret=dict(key='value')
    )

    # Read a secret
    secret = client.secrets.kv.v2.read_secret_version(path='mysecret')
    print(f"Secret: {secret['data']['data']['key']}")

if __name__ == "__main__":
    main()