output "kube_api_lb" {
  description = "Private Kubernetes API load balancer details"
  value       = module.private_lb_kube_api.lb_status
}

output "internal_api_lb" {
  description = "Internal API load balancer details"
  value       = module.private_lb_multi_target.lb_status
}

output "control_plane_servers" {
  description = "Control plane server details"
  value       = module.control_plane_servers.server_info
}
