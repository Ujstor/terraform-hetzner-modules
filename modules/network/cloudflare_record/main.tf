resource "cloudflare_dns_record" "domain_recorda" {
  for_each = var.cloudflare_record

  zone_id  = each.value.zone_id
  name     = each.value.name
  content  = each.value.content
  type     = each.value.type
  ttl      = each.value.ttl
  proxied  = each.value.proxied
  priority = each.value.priority

  dynamic "data" {
    for_each = each.value.data != null ? [each.value.data] : []
    content {
      priority = data.value.priority
      weight   = data.value.weight
      port     = data.value.port
      target   = data.value.target
      service  = data.value.service
      proto    = data.value.proto
      name     = data.value.name
    }
  }
}
