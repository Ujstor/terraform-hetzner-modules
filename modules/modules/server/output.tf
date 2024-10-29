output "server_info" {
  value = {
    for key, _ in var.server_config :
    key => {
      ip     = hcloud_server.server[key].ipv4_address
      status = hcloud_server.server[key].status
    }
  }
}
