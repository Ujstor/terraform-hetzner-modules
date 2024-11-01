module "ssh_key" {
  source       = "../ssh_key/"
  ssh_key_name = var.ssh_key_name
  ssh_key_path = var.ssh_key_path
}

module "server" {
  source            = "../server/"
  server_config     = var.server_config
  hcloud_ssh_key_id = [module.ssh_key.hcloud_ssh_key_id]
  use_network       = var.use_network
  depends_on        = [module.ssh_key]
  firewall_ids      = [module.firewall.firewall_ids.default_firewall.id]
}

module "firewall" {
  source = "../network/firewall"

  firewalls = var.firewall_config
}
