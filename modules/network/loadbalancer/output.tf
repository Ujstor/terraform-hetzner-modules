output "lb_ip" {
  value = {
    for key, _ in var.lb_config :
    key => {
      lb_ip = hcloud_load_balancer.lb[key].ip
    }
  }
}
