output "subnet_id" {
  description = "The ID of the subnet."
  value = {
    for key, _ in var.subnet_config :
    key => {
      subnet_id = hcloud_network_subnet.deployment_subnet[key].id
      network_id = hcloud_network_subnet.deployment_subnet[key].network_zone
    }
  }
}

output "network_id" {
  description = "The ID of the VPC network."
  value       = hcloud_network.network.id
}
