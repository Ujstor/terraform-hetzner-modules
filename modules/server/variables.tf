variable "server_config" {
  description = "Config for each created server"
  type = map(object({
    location     = string
    server_type  = string
    labels       = optional(map(string))
    ipv4_enabled = optional(bool)
    ipv6_enabled = optional(bool)
    subnet_id    = optional(string)
    subnet_ip    = optional(string)
    firewall_ids = optional(list(string))
  }))
}

variable "os_type" {
  description = "OS image to use for the server"
  type        = string
  default     = "debian-12"
}

variable "hcloud_ssh_key_id" {
  description = "ID of the SSH key created and used for Hetzner cloud and serves"
  type        = list(string)
}

variable "use_network" {
  description = "Use VPC and subnets"
  type        = bool
  default     = false
}

variable "firewall_ids" {
  description = "Firewall IDs to pass to the server"
  type        = list(string)
  default     = null
}
