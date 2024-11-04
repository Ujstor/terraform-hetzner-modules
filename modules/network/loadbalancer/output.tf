output "lb_status" {
  value = {
    for key, _ in var.lb_config :
    key => {
      lb_ip = hcloud_load_balancer.lb[key].ipv4
    }
  }
}
