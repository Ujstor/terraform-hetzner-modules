resource "hcloud_volume" "vol" {
  for_each = var.volume_config

  name     = each.key
  size     = each.value.size
  location = each.value.location
  format   = var.volume_format
}

resource "hcloud_volume_attachment" "vol_attachment" {
  for_each = var.volume_config

  volume_id = hcloud_volume.vol[each.key].id
  server_id = each.value.server_id
  automount = true
}
