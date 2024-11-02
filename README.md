# Hetzner Terraform Modules

Modules for simplifying the creation of resources on Hetzner Cloud and Cloudflare.

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)
## Module: cluster

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.37 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.47 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ../network/firewall | n/a |
| <a name="module_server"></a> [server](#module\_server) | ../server/ | n/a |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ../ssh_key/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_config"></a> [firewall\_config](#input\_firewall\_config) | A map of firewalls to create | <pre>map(object({<br/>    name   = string<br/>    labels = optional(map(string), {})<br/>    rules = list(object({<br/>      direction       = string<br/>      protocol       = string<br/>      port          = string<br/>      source_ips     = optional(list(string))<br/>      destination_ips = optional(list(string))<br/>      description    = optional(string)<br/>    }))<br/>  }))</pre> | <pre>{<br/>  "default_firewall": {<br/>    "labels": {<br/>      "type": "firewall-default"<br/>    },<br/>    "name": "default-firewall",<br/>    "rules": [<br/>      {<br/>        "direction": "in",<br/>        "port": "22",<br/>        "protocol": "tcp"<br/>      },<br/>      {<br/>        "destination_ips": [<br/>          "0.0.0.0/0"<br/>        ],<br/>        "direction": "out",<br/>        "port": "22",<br/>        "protocol": "tcp"<br/>      },<br/>      {<br/>        "direction": "in",<br/>        "port": "80",<br/>        "protocol": "tcp"<br/>      },<br/>      {<br/>        "destination_ips": [<br/>          "0.0.0.0/0"<br/>        ],<br/>        "direction": "out",<br/>        "port": "80",<br/>        "protocol": "tcp"<br/>      },<br/>      {<br/>        "direction": "in",<br/>        "port": "443",<br/>        "protocol": "tcp"<br/>      },<br/>      {<br/>        "destination_ips": [<br/>          "0.0.0.0/0"<br/>        ],<br/>        "direction": "out",<br/>        "port": "443",<br/>        "protocol": "tcp"<br/>      }<br/>    ]<br/>  }<br/>}</pre> | no |
| <a name="input_server_config"></a> [server\_config](#input\_server\_config) | Configuration for servers | <pre>map(object({<br/>    location     = string<br/>    server_type  = string<br/>    labels       = string<br/>    ipv4_enabled = optional(bool)<br/>    ipv6_enabled = optional(bool)<br/>    subnet_id    = string<br/>    subnet_ip    = string<br/>    firewall_ids = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | Name of the SSH key | `string` | `"cluster_hetzner_key"` | no |
| <a name="input_ssh_key_path"></a> [ssh\_key\_path](#input\_ssh\_key\_path) | Path to the SSH key | `string` | `"~/.ssh"` | no |
| <a name="input_use_network"></a> [use\_network](#input\_use\_network) | Flag to use network | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_status"></a> [server\_status](#output\_server\_status) | n/a |

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)

## Module: cloudflare_record

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 4.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.domain_recorda](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_record"></a> [cloudflare\_record](#input\_cloudflare\_record) | Cloudflare record configuration | <pre>map(object({<br/>    zone_id = string<br/>    name    = string<br/>    content = string<br/>    type    = string<br/>    ttl     = number<br/>    proxied = bool<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)

## Module: firewall

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
| [hcloud_firewall.default](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewalls"></a> [firewalls](#input\_firewalls) | A map of firewalls to create | <pre>map(object({<br/>    name   = string<br/>    labels = optional(map(string), {})<br/>    rules = list(object({<br/>      direction       = string<br/>      protocol       = string<br/>      port          = string<br/>      source_ips     = optional(list(string))<br/>      destination_ips = optional(list(string))<br/>      description    = optional(string)<br/>    }))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_ids"></a> [firewall\_ids](#output\_firewall\_ids) | n/a |

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)

## Module: vpc_subnet

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
| [hcloud_network.network](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_subnet.deployment_subnet](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | Network Type | `string` | n/a | yes |
| <a name="input_network_zone"></a> [network\_zone](#input\_network\_zone) | Network Zone | `string` | n/a | yes |
| <a name="input_subnet_config"></a> [subnet\_config](#input\_subnet\_config) | Subnet Configuration | <pre>map(object({<br/>    subnet_ip_range = string<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | VPC Configuration | <pre>object({<br/>    vpc_name     = string<br/>    vpc_ip_range = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)

## Module: server

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
| [hcloud_server.server](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server_network.subnet_controler](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall_ids"></a> [firewall\_ids](#input\_firewall\_ids) | Firewall IDs to pass to the server | `list(string)` | `null` | no |
| <a name="input_hcloud_ssh_key_id"></a> [hcloud\_ssh\_key\_id](#input\_hcloud\_ssh\_key\_id) | ID of the SSH key created and used for Hetzner cloud and serves | `list(string)` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | OS image to use for the server | `string` | `"debian-12"` | no |
| <a name="input_server_config"></a> [server\_config](#input\_server\_config) | Config for each created server | <pre>map(object({<br/>    location     = string<br/>    server_type  = string<br/>    labels       = optional(string)<br/>    ipv4_enabled = optional(bool)<br/>    ipv6_enabled = optional(bool)<br/>    subnet_id    = optional(string)<br/>    subnet_ip    = optional(string)<br/>    firewall_ids = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_use_network"></a> [use\_network](#input\_use\_network) | Use VPC and subnets | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_info"></a> [server\_info](#output\_server\_info) | n/a |

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)

## Module: ssh_key

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.47 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.47 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_ssh_key.default](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | Name of the SSH key created and used for Hetzner cloud and serves | `string` | `"hetzner_ssh_key"` | no |
| <a name="input_ssh_key_path"></a> [ssh\_key\_path](#input\_ssh\_key\_path) | Path where the SSH key is stored | `string` | `"~/.ssh"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hcloud_ssh_key_id"></a> [hcloud\_ssh\_key\_id](#output\_hcloud\_ssh\_key\_id) | Pass Hcloud ssh key id into server |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | Public key |

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)

## Module: volumes

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
| [hcloud_volume.vol](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume) | resource |
| [hcloud_volume_attachment.vol_attachment](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_volume_config"></a> [volume\_config](#input\_volume\_config) | Volume configuration | <pre>map(object({<br/>    size = number<br/>    location = string<br/>    server_id = string<br/>  }))</pre> | n/a | yes |
| <a name="input_volume_format"></a> [volume\_format](#input\_volume\_format) | Format volume after creation (xfs or ext4) | `string` | `"xfs"` | no |

## Outputs

No outputs.

![purple-divider](https://user-images.githubusercontent.com/7065401/52071927-c1cd7100-2562-11e9-908a-dde91ba14e59.png)

