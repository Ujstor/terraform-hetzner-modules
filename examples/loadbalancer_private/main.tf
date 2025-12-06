# Example: Private Load Balancer for Kubernetes API
#
# This example demonstrates how to create a private-only load balancer
# for internal Kubernetes API access. The load balancer:
# - Has public interface disabled (enable_public_interface = false)
# - Uses private IP for routing traffic to targets
# - Targets multiple control plane nodes via label selector
# - Includes TCP health check on port 6443

module "ssh_key" {
  source = "../../modules/ssh_key/"

  ssh_key_name = "hetzner_key"
  ssh_key_path = ".ssh"
}

module "vpc_subnets" {
  source = "../../modules/network/vpc_subnet"

  vpc_config = {
    vpc_name     = "k8s-cluster-vpc"
    vpc_ip_range = "10.0.0.0/16"
  }

  subnet_config = {
    control-plane = {
      subnet_ip_range = "10.0.1.0/24"
    }
    workers = {
      subnet_ip_range = "10.0.2.0/24"
    }
  }

  network_type = "cloud"
  network_zone = "eu-central"
}

module "control_plane_servers" {
  source = "../../modules/server/"

  server_config = {
    cp-1 = {
      location     = "fsn1"
      server_type  = "cx22"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id.control-plane.subnet_id
      subnet_ip    = "10.0.1.2"
      labels = {
        role = "control-plane"
      }
    }
    cp-2 = {
      location     = "nbg1"
      server_type  = "cx22"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id.control-plane.subnet_id
      subnet_ip    = "10.0.1.3"
      labels = {
        role = "control-plane"
      }
    }
    cp-3 = {
      location     = "hel1"
      server_type  = "cx22"
      ipv4_enabled = true
      ipv6_enabled = false
      subnet_id    = module.vpc_subnets.subnet_id.control-plane.subnet_id
      subnet_ip    = "10.0.1.4"
      labels = {
        role = "control-plane"
      }
    }
  }

  hcloud_ssh_key_id = [module.ssh_key.hcloud_ssh_key_id]
  use_network       = true

  depends_on = [module.ssh_key, module.vpc_subnets]
}

# Private Load Balancer for Kubernetes API
module "private_lb_kube_api" {
  source = "../../modules/network/loadbalancer"

  lb_config = {
    kube-api = {
      name               = "kube-api-private-lb"
      load_balancer_type = "lb11"
      network_zone       = "eu-central"
      labels = {
        purpose     = "kube-api"
        environment = "production"
        visibility  = "private"
      }

      # Network configuration with PRIVATE-ONLY mode
      load_balancer_network = {
        subnet_id               = module.vpc_subnets.subnet_id.control-plane.subnet_id
        ip                      = "10.0.1.100" # Static private IP for kube API
        enable_public_interface = false        # DISABLE public interface
      }

      # Target all control plane nodes via label selector
      load_balancer_targets = [
        {
          type           = "label_selector"
          label_selector = "role=control-plane"
          use_private_ip = true # Route via private network
        }
      ]

      # Kubernetes API service on port 6443
      load_balancer_service = [
        {
          protocol         = "tcp"
          listen_port      = 6443
          destination_port = 6443
          health_check = {
            protocol = "tcp"
            port     = 6443
            interval = 15
            timeout  = 10
            retries  = 3
          }
        }
      ]
    }
  }

  depends_on = [module.vpc_subnets, module.control_plane_servers]
}

# Example: Multiple targets using IP addresses
module "private_lb_multi_target" {
  source = "../../modules/network/loadbalancer"

  lb_config = {
    internal-api = {
      name               = "internal-api-lb"
      load_balancer_type = "lb11"
      network_zone       = "eu-central"
      labels = {
        purpose = "internal-api"
      }

      load_balancer_network = {
        subnet_id               = module.vpc_subnets.subnet_id.control-plane.subnet_id
        ip                      = "10.0.1.200"
        enable_public_interface = false
      }

      # Multiple IP-based targets
      load_balancer_targets = [
        {
          type = "ip"
          ip   = "10.0.1.2"
        },
        {
          type = "ip"
          ip   = "10.0.1.3"
        },
        {
          type = "ip"
          ip   = "10.0.1.4"
        }
      ]

      # HTTP service with health check
      load_balancer_service = [
        {
          protocol         = "http"
          listen_port      = 80
          destination_port = 8080
          health_check = {
            protocol = "http"
            port     = 8080
            interval = 10
            timeout  = 5
            retries  = 3
            http = {
              path         = "/health"
              status_codes = ["200", "2??"]
            }
          }
        }
      ]
    }
  }

  depends_on = [module.vpc_subnets, module.control_plane_servers]
}
