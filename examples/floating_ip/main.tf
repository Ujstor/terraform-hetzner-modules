module "ssh_key_test" {
  source = "../../modules/ssh_key/"
}

module "servers" {
  source = "../../modules/server/"

  server_config = {
    server-1 = {
      location    = "fsn1"
      server_type = "cx22"
    }
    server-2 = {
      location    = "hel1"
      server_type = "cx22"
    }
  }

  hcloud_ssh_key_id = [module.ssh_key_test.hcloud_ssh_key_id]

  depends_on = [module.ssh_key_test]
}

module "floating_ip" {
  source = "../../modules/network/floating_ip"

  floating_ip_config = {
    ip-1 = {
      server_id       = module.servers.server_info.server-1.id
      server_location = module.servers.server_info.server-1.location
    }
    ip-2 = {
      server_id       = module.servers.server_info.server-1.id
      server_location = module.servers.server_info.server-1.location
    }
    ip-3 = {
      server_id       = module.servers.server_info.server-2.id
      server_location = module.servers.server_info.server-2.location
    }
  }
}
