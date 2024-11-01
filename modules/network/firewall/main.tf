resource "hcloud_firewall" "default" {
  for_each = var.firewalls
  name     = each.value.name
  labels   = each.value.labels

  dynamic "rule" {
    for_each = each.value.rules
    content {
      direction = rule.value.direction
      protocol  = rule.value.protocol
      port      = rule.value.port
      source_ips = rule.value.direction == "in" ? coalesce(
        rule.value.source_ips, ["0.0.0.0/0", "::/0"]) : null
      destination_ips = rule.value.direction == "out" ? coalesce(
        rule.value.destination_ips, ["0.0.0.0/0"]) : null
      description = try(rule.value.description, null)
    }
  }
}
