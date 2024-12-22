output "servers_info" {
  value = module.servers.server_info
}

output "floating_ip_info" {
  value = module.floating_ip.floating_ip_status
}
