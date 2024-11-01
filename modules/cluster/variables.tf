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
  description = "Configuration for servers"
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

variable "firewall_config" {
  description = "A map of firewalls to create"
  type = map(object({
    name   = string
    labels = optional(map(string), {})
    rules = list(object({
      direction       = string
      protocol       = string
      port          = string
      source_ips     = optional(list(string))
      destination_ips = optional(list(string))
      description    = optional(string)
    }))
  }))
  default = {
    default_firewall = {
      labels = {
        type = "firewall-default"
      }
      name = "default-firewall"
      rules = [
        {
          direction = "in"
          port      = "22"
          protocol  = "tcp"
        },
        {
          destination_ips = ["0.0.0.0/0"]
          direction       = "out"
          port            = "22"
          protocol        = "tcp"
        },
        {
          direction = "in"
          port      = "80"
          protocol  = "tcp"
        },
        {
          destination_ips = ["0.0.0.0/0"]
          direction       = "out"
          port            = "80"
          protocol        = "tcp"
        },
        {
          direction = "in"
          port      = "443"
          protocol  = "tcp"
        },
        {
          destination_ips = ["0.0.0.0/0"]
          direction       = "out"
          port            = "443"
          protocol        = "tcp"
        },
      ]
    }
  }
}

