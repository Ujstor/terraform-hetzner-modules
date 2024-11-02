module "ssh_key_test" {
  source = "../../modules/ssh_key/"
}

module "servers" {
  source = "../../modules/server/"

  server_config = {
    server-1 = {
      location     = "fsn1"
      server_type  = "cx22"
    }
    server-2 = {
      location     = "hel1"
      server_type  = "cx22"
    }
    server-3 = {
      location     = "fsn1"
      server_type  = "cx22"
    }
  }

  hcloud_ssh_key_id = [module.ssh_key_test.hcloud_ssh_key_id]

  depends_on = [module.ssh_key_test]
}

module "volumes" {
  source = "../../modules/volumes/"

  volume_config = {
    volume-1 = {
      size     = 10
      location = module.servers.server_info.server-1.location
      server_id = module.servers.server_info.server-1.id
    }
    volume-2 = {
      size     = 10
      location = module.servers.server_info.server-2.location
      server_id = module.servers.server_info.server-2.id
    }
    volume-3 = {
      size     = 10
      location = module.servers.server_info.server-3.location
      server_id = module.servers.server_info.server-3.id
    }
  }

  depends_on = [module.servers]
}

