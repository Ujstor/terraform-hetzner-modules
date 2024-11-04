output "servers_info" {
  value = module.servers.server_info
}

output "lb_status" {
  value = module.load_balancer.lb_status
}
