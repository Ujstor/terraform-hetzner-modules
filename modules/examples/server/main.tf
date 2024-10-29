module "ssh_key_test" {
  source = "../../modules/ssh_key/"

  ssh_key_name = "hetzner_key"
  ssh_key_path = ".ssh" #create dir before appling tf config if you use custom paths for ssh keys
}

module "servers_test" {
  source = "../../modules/server/"

  server_config = {
    server-1 = {
      location     = "fsn1"
      server_type  = "cx22"
      ipv4_enabled = true
      ipv6_enabled = false
    }
  }

  os_type = "ubuntu-22.04"

  hcloud_ssh_key_id = [module.ssh_key_test.hcloud_ssh_key_id]

  depends_on = [module.ssh_key_test]
}
