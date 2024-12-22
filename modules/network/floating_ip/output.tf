output "floating_ip_status" {
  value = {
    for key, _ in var.floating_ip_config :
    key => {
      ip = hcloud_floating_ip.main[key].ip_address
    }
  }
}
