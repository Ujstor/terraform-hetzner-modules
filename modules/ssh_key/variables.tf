variable "ssh_key_name" {
  type        = string
  description = "Name of the SSH key created and used for Hetzner cloud and serves"
  default     = "hetzner_ssh_key"
}
