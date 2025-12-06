resource "hcloud_floating_ip" "main" {
  for_each = var.floating_ip_config

  type              = var.ip_type
  home_location     = each.value.server_location
  delete_protection = each.value.delete_protection
}

resource "hcloud_floating_ip_assignment" "main" {
  for_each = var.floating_ip_config

  floating_ip_id = hcloud_floating_ip.main[each.key].id
  server_id      = each.value.server_id
}
