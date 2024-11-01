variable "firewalls" {
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

  validation {
    condition = alltrue([
      for fw in var.firewalls : alltrue([
        for rule in fw.rules : contains(["in", "out"], rule.direction)
      ])
    ])
    error_message = "Direction must be either 'in' or 'out'."
  }
}
