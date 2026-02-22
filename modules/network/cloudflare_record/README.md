## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.domain_recorda](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_record"></a> [cloudflare\_record](#input\_cloudflare\_record) | Cloudflare record configuration | <pre>map(object({<br>    zone_id  = string<br>    name     = string<br>    content  = optional(string)<br>    type     = string<br>    ttl      = optional(number)<br>    proxied  = optional(bool)<br>    priority = optional(number)<br>    data     = optional(map(any))<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
