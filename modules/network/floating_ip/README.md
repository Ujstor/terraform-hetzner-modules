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
| [hcloud_floating_ip.main](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/floating_ip) | resource |
| [hcloud_floating_ip_assignment.main](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/floating_ip_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_floating_ip_config"></a> [floating\_ip\_config](#input\_floating\_ip\_config) | Floating IP configuration | <pre>map(object({<br>    server_id       = string<br>    server_location = string<br>  }))</pre> | n/a | yes |
| <a name="input_ip_type"></a> [ip\_type](#input\_ip\_type) | Type of IP address | `string` | `"ipv4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_floating_ip_status"></a> [floating\_ip\_status](#output\_floating\_ip\_status) | n/a |
