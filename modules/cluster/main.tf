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
  firewall_ids      = [for f in module.firewall.firewall_ids : f.id]
}

module "firewall" {
  source    = "../network/firewall"
  firewalls = local.merged_firewall_config
}

locals {
  default_firewall_config = {
    default_firewall = {
      labels = {
        type = "firewall-default"
      }
      name = "default-firewall"
      rules = [
        {
          direction = "in"
          port      = "22"
          protocol  = "tcp"
        },
        {
          destination_ips = ["0.0.0.0/0"]
          direction       = "out"
          port            = "22"
          protocol        = "tcp"
        },
        {
          direction = "in"
          port      = "80"
          protocol  = "tcp"
        },
        {
          destination_ips = ["0.0.0.0/0"]
          direction       = "out"
          port            = "80"
          protocol        = "tcp"
        },
        {
          direction = "in"
          port      = "443"
          protocol  = "tcp"
        },
        {
          destination_ips = ["0.0.0.0/0"]
          direction       = "out"
          port            = "443"
          protocol        = "tcp"
        },
      ]
    }
  }

  merged_firewall_config = merge(local.default_firewall_config, var.firewall_config)
}
