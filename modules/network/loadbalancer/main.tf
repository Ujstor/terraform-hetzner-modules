resource "hcloud_load_balancer" "lb" {
  for_each = var.lb_config

  name               = each.value.name
  load_balancer_type = each.value.load_balancer_type
  network_zone       = each.value.network_zone
  location           = each.value.location
  delete_protection  = each.value.delete_protection
  labels             = each.value.labels

  dynamic "algorithm" {
    for_each = each.value.algorithm != null ? [each.value.algorithm] : []
    content {
      type = algorithm.value.type
    }
  }
}

# Load balancer targets (now supports multiple targets per LB)
# When use_private_ip is true, the LB must be attached to a network first
resource "hcloud_load_balancer_target" "load_balancer_target" {
  for_each = {
    for item in flatten([
      for lb_key, lb in var.lb_config : [
        for idx, target in coalesce(lb.load_balancer_targets, []) : {
          key    = "${lb_key}-${idx}"
          target = target
          lb_key = lb_key
        }
      ]
    ]) : item.key => item
  }

  type             = each.value.target.type
  load_balancer_id = hcloud_load_balancer.lb[each.value.lb_key].id
  server_id        = each.value.target.server_id
  label_selector   = each.value.target.label_selector
  ip               = each.value.target.ip
  use_private_ip   = each.value.target.use_private_ip

  # Must wait for network attachment when using private IPs
  depends_on = [hcloud_load_balancer_network.serve_network]
}

# Load balancer network
resource "hcloud_load_balancer_network" "serve_network" {
  for_each = {
    for lb_key, lb in var.lb_config : lb_key => lb.load_balancer_network
    if lb.load_balancer_network != null
  }

  load_balancer_id        = hcloud_load_balancer.lb[each.key].id
  network_id              = each.value.network_id
  subnet_id               = each.value.subnet_id
  ip                      = each.value.ip
  enable_public_interface = each.value.enable_public_interface
}

# Load balancer service (now supports multiple services per LB with health checks)
resource "hcloud_load_balancer_service" "load_balancer_service" {
  for_each = {
    for item in flatten([
      for lb_key, lb in var.lb_config : [
        for idx, service in coalesce(lb.load_balancer_service, []) : {
          key     = "${lb_key}-${idx}"
          service = service
          lb_key  = lb_key
        }
      ]
    ]) : item.key => item
  }

  load_balancer_id = hcloud_load_balancer.lb[each.value.lb_key].id
  protocol         = each.value.service.protocol
  listen_port      = each.value.service.listen_port
  destination_port = each.value.service.destination_port
  proxyprotocol    = each.value.service.proxyprotocol

  dynamic "health_check" {
    for_each = each.value.service.health_check != null ? [each.value.service.health_check] : []
    content {
      protocol = health_check.value.protocol
      port     = health_check.value.port
      interval = health_check.value.interval
      timeout  = health_check.value.timeout
      retries  = health_check.value.retries

      dynamic "http" {
        for_each = health_check.value.http != null ? [health_check.value.http] : []
        content {
          domain       = http.value.domain
          path         = http.value.path
          response     = http.value.response
          tls          = http.value.tls
          status_codes = http.value.status_codes
        }
      }
    }
  }

  dynamic "http" {
    for_each = each.value.service.http != null ? [each.value.service.http] : []
    content {
      sticky_sessions = http.value.sticky_sessions
      cookie_name     = http.value.cookie_name
      cookie_lifetime = http.value.cookie_lifetime
      certificates    = http.value.certificates
      redirect_http   = http.value.redirect_http
    }
  }
}
