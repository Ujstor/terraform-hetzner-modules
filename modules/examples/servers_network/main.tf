module "ssh_key_test" {
  source = "../../modules/ssh_key/"

  ssh_key_name = "hetzner_key"
  ssh_key_path = ".ssh"
}

module "cluster" {
  source = "../../modules/server/"

  server_config = {
    server-1 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "servers-1"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id["subnet-1"].subnet_id
      subnet_ip    = "10.0.1.1"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-2 = {
      location     = "hel1"
      server_type  = "cx22"
      labels       = "servers-1"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id["subnet-1"].subnet_id
      subnet_ip    = "10.0.1.2"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-3 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "servers-2"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id["subnet-2"].subnet_id
      subnet_ip    = "10.0.2.1"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-4 = {
      location     = "hel1"
      server_type  = "cx22"
      labels       = "servers-2"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id["subnet-2"].subnet_id
      subnet_ip    = "10.0.3.2"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-5 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "servers-3"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id["subnet-3"].subnet_id
      subnet_ip    = "10.0.3.1"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
    server-6 = {
      location     = "nbg1"
      server_type  = "cx22"
      labels       = "servers-3"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id["subnet-3"].subnet_id
      subnet_ip    = "10.0.3.2"
      firewall_ids = [module.firewall.firewall_ids["default"].id]
    }
  }

  os_type = "ubuntu-22.04"

  hcloud_ssh_key_id = [module.ssh_key_test.hcloud_ssh_key_id]

  use_network = true

  depends_on = [module.ssh_key_test]
}

module "cloudflare_record" {
  source = "../../modules/network/cloudflare_record/"

  cloudflare_record = {
    foo = {
      zone_id = var.cloudflare_zone_id
      name    = "foo"
      values   = module.cluster.server_info.server-1.ip
      type    = "A"
      ttl     = 1
      proxied = true
    }
    bar = {
      zone_id = var.cloudflare_zone_id
      name    = "bar"
      values   = module.cluster.server_info.server-2.ip
      type    = "A"
      ttl     = 1
      proxied = true
    }
  }
    depends_on = [module.cluster]
}

module "vpc_subnets" {
  source = "../../modules/network/vpc_subnet"

  vpc_config = {
    vpc_name     = "servers-vpc"
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

