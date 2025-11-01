variable "cloudflare_record" {
  description = "Cloudflare record configuration"
  type = map(object({
    zone_id  = string
    name     = string
    content  = optional(string)
    type     = string
    ttl      = optional(number)
    proxied  = optional(bool)
    priority = optional(number)
    data = optional(object({
      priority = optional(number)
      weight   = optional(number)
      port     = optional(number)
      target   = optional(string)
      service  = optional(string)
      proto    = optional(string)
      name     = optional(string)
    }))
  }))
}
