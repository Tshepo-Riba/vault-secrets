variable "ami_id" {
  description = "AMI ID for Vault instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Vault instances"
  type        = string
  default     = "t2.medium"
}

variable "subnet_id" {
  description = "ID of the subnet where Vault instances will be deployed"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for Vault instances"
  type        = list(string)
}

variable "vault_count" {
  description = "Number of Vault instances to deploy for HA"
  type        = number
  default     = 3
}

variable "vault_backend" {
  description = "Type of Vault backend to use (e.g., consul, dynamodb)"
  type        = string
}

variable "vault_backend_config" {
  description = "Configuration specific to the chosen Vault backend"
  type        = map(any)
}


