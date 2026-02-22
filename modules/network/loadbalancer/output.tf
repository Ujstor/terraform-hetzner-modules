output "lb_status" {
  description = "Load balancer status including public and private IPs"
  value = {
    for key, lb in var.lb_config :
    key => {
      id            = hcloud_load_balancer.lb[key].id
      name          = hcloud_load_balancer.lb[key].name
      lb_ip         = hcloud_load_balancer.lb[key].ipv4
      lb_ipv6       = hcloud_load_balancer.lb[key].ipv6
      lb_private_ip = try(hcloud_load_balancer_network.serve_network[key].ip, null)
      network_id    = try(hcloud_load_balancer_network.serve_network[key].network_id, null)
    }
  }
}
