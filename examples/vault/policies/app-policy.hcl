# vault/policies/app-policy.hcl
path "secret/data/mysecret" {
  capabilities = ["read", "create", "update"]
}