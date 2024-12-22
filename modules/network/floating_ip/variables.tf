variable "floating_ip_config" {
  description = "Floating IP configuration"
  type = map(object({
    server_id       = string
    server_location = string
  }))
}

variable "ip_type" {
  description = "Type of IP address"
  type        = string
  default     = "ipv4"
}
