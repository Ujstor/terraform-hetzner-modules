variable "ssh_key_name" {
  description = "Name of the SSH key"
  type        = string
  default     = "cluster_hetzner_key"
}

variable "ssh_key_path" {
  description = "Path to the SSH key"
  type        = string
  default     = "~/.ssh"
}

variable "server_config" {
  description = "Configuration for server"
  type = map(object({
    location     = string
    server_type  = string
    labels       = string
    ipv4_enabled = optional(bool)
    ipv6_enabled = optional(bool)
    subnet_id    = string
    subnet_ip    = string
    firewall_ids = optional(list(string))
  }))
}

variable "use_network" {
  description = "Flag to use network"
  type        = bool
  default     = true
}

variable "os_type" {
  description = "OS image to use for the server"
  type        = string
  default     = "debian-12"
}
