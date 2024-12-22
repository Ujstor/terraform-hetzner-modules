variable "cloudflare_record" {
  description = "Cloudflare record configuration"
  type = map(object({
    zone_id = string
    name    = string
    content = string
    type    = string
    ttl     = optional(number)
    proxied = optional(bool)
  }))
}
