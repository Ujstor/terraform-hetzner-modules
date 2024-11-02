output "firewall_ids" {
  value = {
    for key, _ in var.firewalls :
    key => {
      id = hcloud_firewall.default[key].id
    }
  }
}

output "firewall_ids_list" {
  value = [for key, _ in var.firewalls : hcloud_firewall.default[key].id]
}
