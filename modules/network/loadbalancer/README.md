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
| <a name="input_lb_config"></a> [lb\_config](#input\_lb\_config) | Load balancer configuration. | <pre>map(object({<br>    name               = string<br>    load_balancer_type = string<br>    network_zone       = optional(string)<br>    location           = optional(string) #Require when no network_zone is set<br>    algorithm          = optional(object({ type = string }))<br>    labels             = optional(map(string))<br>    load_balancer_targets = optional(object({<br>      type           = string           #server, label_selector, ip<br>      server_id      = optional(string) #if type server<br>      label_selector = optional(string)<br>      ip             = optional(string) #if type ip<br>      use_private_ip = optional(bool)   #if type server or label_selector<br>    }))<br>    load_balancer_network = optional(object({<br>      #Use depends_on to make sure the network is created before the load balancer<br>      network_id = optional(string) #or network id or subnet id<br>      subnet_id  = optional(string)<br>      ip         = optional(string) #subnet ip<br>    }))<br>    load_balancer_service = optional(object({<br>      service_id       = optional(string)<br>      protocol         = optional(string)<br>      listen_port      = optional(number)<br>      destination_port = optional(number)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_status"></a> [lb\_status](#output\_lb\_status) | n/a |
