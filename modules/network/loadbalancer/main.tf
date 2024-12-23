resource "hcloud_load_balancer" "lb" {
  for_each = var.lb_config

  name               = each.value.name
  load_balancer_type = each.value.load_balancer_type
  network_zone       = each.value.network_zone
  location           = each.value.location
  labels             = each.value.labels

  dynamic "algorithm" {
    for_each = each.value.algorithm != null ? [each.value.algorithm] : []
    content {
      type = algorithm.value.type
    }
  }
}

# Load balancer targets
resource "hcloud_load_balancer_target" "load_balancer_target" {
  for_each = {
    for idx, item in flatten([
      for lb_key, lb in var.lb_config : lb.load_balancer_targets != null ? [
        {
          key    = lb_key
          target = lb.load_balancer_targets
          lb_key = lb_key
        }
      ] : []
    ]) : idx => item
  }
  type             = each.value.target.type
  load_balancer_id = hcloud_load_balancer.lb[each.value.lb_key].id
  server_id        = each.value.target.server_id
  label_selector   = each.value.target.label_selector
  ip               = each.value.target.ip
  use_private_ip   = each.value.target.use_private_ip
}

# Load balancer network
resource "hcloud_load_balancer_network" "serve_network" {
  for_each = {
    for idx, item in flatten([
      for lb_key, lb in var.lb_config : lb.load_balancer_network != null ? [
        {
          key     = lb_key
          network = lb.load_balancer_network
          lb_key  = lb_key
        }
      ] : []
    ]) : idx => item
  }

  load_balancer_id = hcloud_load_balancer.lb[each.value.lb_key].id
  network_id       = each.value.network.network_id
  subnet_id        = each.value.network.subnet_id
  ip               = each.value.network.ip
}

# Load balancer service
resource "hcloud_load_balancer_service" "load_balancer_service" {
  for_each = {
    for idx, item in flatten([
      for lb_key, lb in var.lb_config : lb.load_balancer_service != null ? [
        {
          key     = lb_key
          service = lb.load_balancer_service
          lb_key  = lb_key
        }
      ] : []
    ]) : idx => item
  }

  load_balancer_id = hcloud_load_balancer.lb[each.value.lb_key].id
  protocol         = each.value.service.protocol
  listen_port      = each.value.service.listen_port
  destination_port = each.value.service.destination_port
}
