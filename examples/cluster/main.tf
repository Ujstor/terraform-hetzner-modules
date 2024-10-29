locals {
  server_ips = { for server in data.hcloud_servers.runing_servers.servers : server.name => server.ipv4_address }
}

module "cluster" {
  source = "../../modules/cluster/"

  server_config = {
    server-1 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "servers-1"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-1"].subnet_id
      subnet_ip    = "10.0.1.1"
    }
    server-2 = {
      location     = "nbg1"
      server_type  = "cx22"
      labels       = "servers-1"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-1"].subnet_id
      subnet_ip    = "10.0.1.2"
    }
    server-3 = {
      location     = "hel1"
      server_type  = "cx22"
      labels       = "servers-2"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-2"].subnet_id
      subnet_ip    = "10.0.2.1"
    }
    server-4 = {
      location     = "hel1"
      server_type  = "cx22"
      labels       = "servers-2"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-2"].subnet_id
      subnet_ip    = "10.0.2.2"
    }
    server-5 = {
      location     = "fsn1"
      server_type  = "cx22"
      labels       = "servers-3"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-3"].subnet_id
      subnet_ip    = "10.0.3.1"
    }
    server-6 = {
      location     = "nbg1"
      server_type  = "cx22"
      labels       = "servers-3"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.network_config.subnet_id["subnet-3"].subnet_id
      subnet_ip    = "10.0.3.2"
    }
  }

  cloudflare_record = {
    app_foo = {
      zone_id = var.cloudflare_zone_id
      name    = "foo"
      values   = local.server_ips["server-1"] 
      type    = "A"
      ttl     = 1
      proxied = true
    }
    app_bar = {
      zone_id = var.cloudflare_zone_id
      name    = "bar"
      values   = local.server_ips["server-2"] 
      type    = "A"
      ttl     = 1
      proxied = true
    }
    app_buu = {
      zone_id = var.cloudflare_zone_id
      name    = "@"
      values   = local.server_ips["server-3"] 
      type    = "A"
      ttl     = 1
      proxied = true
    }
    app_test= {
      zone_id = var.cloudflare_zone_id
      name    = "app-bar"
      values   = local.server_ips["server-4"] 
      type    = "A"
      ttl     = 1
      proxied = true
    }
  }
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
