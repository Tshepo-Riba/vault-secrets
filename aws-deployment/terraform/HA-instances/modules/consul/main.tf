variable "consul_address" {
  description = "Address of the Consul server"
  type        = string
}

resource "vault_backend_consul" "consul_backend" {
  address = var.consul_address
  path    = "vault/"
}
