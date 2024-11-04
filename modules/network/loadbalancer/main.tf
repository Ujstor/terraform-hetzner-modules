resource "hcloud_load_balancer" "lb" {
  for_each = var.lb_config

  name               = each.value.name
  load_balancer_type = each.value.load_balancer_type
  network_zone       = each.value.network_zone
  location           = each.value.location
  # algorithm          = each.value.algorithm
  labels             = each.value.labels
}

resource "hcloud_load_balancer_target" "load_balancer_target" {
  for_each = {for idx, target in var.lb_config[each.key].load_balancer_targets : idx => target}

  type             = each.value.type
  load_balancer_id = hcloud_load_balancer.lb[each.key].id
  server_id        = each.value.server_id
  label_selector   = each.value.label_selector
  ip               = each.value.ip
  use_private_ip   = each.value.use_private_ip
}

resource "hcloud_load_balancer_network" "serve_network" {
  for_each = {for idx, network in var.lb_config[each.key].load_balancer_network : idx => network}

  load_balancer_id = hcloud_load_balancer.lb[each.key].id
  network_id       = each.value.network_id
  ip               = each.value.ip
}
