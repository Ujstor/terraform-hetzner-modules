module "cluster" {
  source = "../../modules/cluster/"

  ssh_key_name = "cluster_hetzner_key"
  ssh_key_path = ".ssh"

  server_config = {
    server-1 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "servers-1"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-1"].subnet_id
      subnet_ip    = "10.0.1.1"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-2 = {
      location     = "nbg1"
      server_type  = "cx22"
      labels       = "servers-1"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-1"].subnet_id
      subnet_ip    = "10.0.1.2"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-3 = {
      location     = "hel1"
      server_type  = "cx22"
      labels       = "servers-2"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-2"].subnet_id
      subnet_ip    = "10.0.2.1"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-4 = {
      location     = "hel1"
      server_type  = "cx22"
      labels       = "servers-2"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-2"].subnet_id
      subnet_ip    = "10.0.2.2"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-5 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "servers-3"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-3"].subnet_id
      subnet_ip    = "10.0.3.1"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-6 = {
      location     = "nbg1"
      server_type  = "cx22"
      labels       = "servers-3"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-3"].subnet_id
      subnet_ip    = "10.0.3.2"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
  }
}


module "cloudflare_record" {
  source = "../../modules/network/cloudflare_record/"

  cloudflare_record = {
    foo = {
      zone_id = var.cloudflare_zone_id
      name    = "foo"
      values   = module.cluster.server_status.server-1.ip
      type    = "A"
      ttl     = 1
      proxied = true
    }
    bar = {
      zone_id = var.cloudflare_zone_id
      name    = "bar"
      values   = module.cluster.server_status.server-2.ip
      type    = "A"
      ttl     = 1
      proxied = true
    }
  }
    depends_on = [module.cluster]
}

module "network_config" {
  source = "../../modules/network/vpc_subnet/"

  vpc_config = {
    vpc_name     = "cluster-vpc"
    vpc_ip_range = "10.0.0.0/16"
  }

  subnet_config = {
    subnet-1 = {
      subnet_ip_range = "10.0.1.0/24"
    }
    subnet-2 = {
      subnet_ip_range = "10.0.2.0/24"
    }
    subnet-3 = {
      subnet_ip_range = "10.0.3.0/24"
    }
  }

  network_type = "cloud"
  network_zone = "eu-central"
}

module "firewall" {
  source = "../../modules/network/firewall"

  firewalls = {
    default = {
      labels = {
        type = "firewall-1"
      }
      name = "firewall-default"

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
}

