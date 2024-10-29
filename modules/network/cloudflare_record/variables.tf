variable "cloudflare_record" {
  description = "Cloudflare record configuration"
  type = map(object({
    zone_id = string
    name    = string
    values   = string
    type    = string
    ttl     = number
    proxied = bool
  }))
}
