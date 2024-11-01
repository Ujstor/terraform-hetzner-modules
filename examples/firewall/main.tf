module "ssh_key_test" {
  source = "../../modules/ssh_key/"
}
module "firewall_test" {
  source = "../../modules/network/firewall"

  firewalls = {
    ssh = {
      labels = {
        type = "ssh-fw"
      }
      name = "firewall-ssh"

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
      ]
    }
    https = {
      labels = {
        type = "http-s-fw"
      }
      name = "firewall-http-s"

      rules = [
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
