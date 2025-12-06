## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.47 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_load_balancer.lb](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer) | resource |
| [hcloud_load_balancer_network.serve_network](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_network) | resource |
| [hcloud_load_balancer_service.load_balancer_service](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_service) | resource |
| [hcloud_load_balancer_target.load_balancer_target](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lb_config"></a> [lb\_config](#input\_lb\_config) | Load balancer configuration. | <pre>map(object({<br>    name               = string<br>    load_balancer_type = string<br>    network_zone       = optional(string)<br>    location           = optional(string) #Require when no network_zone is set<br>    delete_protection  = optional(bool, false)<br>    algorithm          = optional(object({ type = string }))<br>    labels             = optional(map(string))<br>    load_balancer_targets = optional(list(object({<br>      type           = string           #server, label_selector, ip<br>      server_id      = optional(string) #if type server<br>      label_selector = optional(string)<br>      ip             = optional(string) #if type ip<br>      use_private_ip = optional(bool)   #if type server or label_selector<br>    })))<br>    load_balancer_network = optional(object({<br>      #Use depends_on to make sure the network is created before the load balancer<br>      network_id              = optional(string)       #or network id or subnet id<br>      subnet_id               = optional(string)<br>      ip                      = optional(string)       #subnet ip<br>      enable_public_interface = optional(bool, true)   #disable public interface for private-only LB<br>    }))<br>    load_balancer_service = optional(list(object({<br>      protocol         = optional(string)<br>      listen_port      = optional(number)<br>      destination_port = optional(number)<br>      proxyprotocol    = optional(bool)<br>      health_check = optional(object({<br>        protocol = string                              #http, https, tcp<br>        port     = number<br>        interval = optional(number, 15)                #seconds<br>        timeout  = optional(number, 10)                #seconds<br>        retries  = optional(number, 3)<br>        http = optional(object({<br>          domain       = optional(string)<br>          path         = optional(string, "/")<br>          response     = optional(string)<br>          tls          = optional(bool)<br>          status_codes = optional(list(string), ["2??", "3??"])<br>        }))<br>      }))<br>      http = optional(object({<br>        sticky_sessions = optional(bool)<br>        cookie_name     = optional(string)<br>        cookie_lifetime = optional(number)<br>        certificates    = optional(list(string))<br>        redirect_http   = optional(bool)<br>      }))<br>    })))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_status"></a> [lb\_status](#output\_lb\_status) | Load balancer status including public and private IPs |
