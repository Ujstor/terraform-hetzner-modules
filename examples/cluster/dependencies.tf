data "hcloud_servers" "runing_servers" {

  with_status = ["running"]

  depends_on = [module.network_config]
}
