variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-west-2"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.medium"
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "vault_ami_id" {
  description = "The AMI ID for the Vault instance"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the instance will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID where the instance will be deployed"
  type        = string
}
