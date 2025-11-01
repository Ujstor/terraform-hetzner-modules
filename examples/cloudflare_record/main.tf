# Example: Cloudflare DNS Records
# This example demonstrates various DNS record types including:
# - Simple A records
# - CNAME records
# - TXT records (SPF, DKIM, DMARC)
# - MX records
# - SRV records (both enabled and disabled services)

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
  default     = "your-zone-id-here"
}

module "cloudflare_record" {
  source = "../../modules/network/cloudflare_record"

  cloudflare_record = {
    # Example 1: Simple A record
    web_server = {
      zone_id = var.cloudflare_zone_id
      name    = "www.example.com"
      content = "192.0.2.1"
      type    = "A"
      ttl     = 60
      proxied = true
    }

    # Example 2: Wildcard A record (backward compatible)
    wildcard_web = {
      zone_id = var.cloudflare_zone_id
      name    = "*.example.com"
      content = "192.0.2.2"
      type    = "A"
      ttl     = 60
      proxied = false
    }

    # Example 3: CNAME record
    mail_autoconfig = {
      zone_id = var.cloudflare_zone_id
      name    = "autoconfig.example.com"
      content = "mail.example.com"
      type    = "CNAME"
      ttl     = 600
      proxied = false
    }

    # Example 4: MX record with priority
    mx_record = {
      zone_id  = var.cloudflare_zone_id
      name     = "example.com"
      content  = "mail.example.com"
      type     = "MX"
      ttl      = 600
      priority = 10
      proxied  = false
    }

    # Example 5: TXT record for SPF
    spf_record = {
      zone_id = var.cloudflare_zone_id
      name    = "example.com"
      content = "v=spf1 mx a:mail.example.com ~all"
      type    = "TXT"
      ttl     = 600
    }

    # Example 6: TXT record for DKIM
    dkim_record = {
      zone_id = var.cloudflare_zone_id
      name    = "dkim._domainkey.example.com"
      content = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA..."
      type    = "TXT"
      ttl     = 600
    }

    # Example 7: TXT record for DMARC
    dmarc_record = {
      zone_id = var.cloudflare_zone_id
      name    = "_dmarc.example.com"
      content = "v=DMARC1; p=reject; adkim=s; aspf=s"
      type    = "TXT"
      ttl     = 600
    }

    # Example 8: SRV record - IMAPS (enabled service)
    srv_imaps = {
      zone_id = var.cloudflare_zone_id
      name    = "_imaps._tcp.example.com"
      type    = "SRV"
      ttl     = 600
      data = {
        priority = 10
        weight   = 1
        port     = 993
        target   = "mail.example.com"
      }
    }

    # Example 9: SRV record - Submissions (enabled service)
    srv_submissions = {
      zone_id = var.cloudflare_zone_id
      name    = "_submissions._tcp.example.com"
      type    = "SRV"
      ttl     = 600
      data = {
        priority = 10
        weight   = 1
        port     = 465
        target   = "mail.example.com"
      }
    }

    # Example 10: SRV record - Submission (enabled service)
    srv_submission = {
      zone_id = var.cloudflare_zone_id
      name    = "_submission._tcp.example.com"
      type    = "SRV"
      ttl     = 600
      data = {
        priority = 10
        weight   = 1
        port     = 587
        target   = "mail.example.com"
      }
    }

    # Example 11: SRV record - Autodiscover (enabled service)
    srv_autodiscover = {
      zone_id = var.cloudflare_zone_id
      name    = "_autodiscover._tcp.example.com"
      type    = "SRV"
      ttl     = 600
      data = {
        priority = 10
        weight   = 1
        port     = 443
        target   = "mail.example.com"
      }
    }

    # Example 12: SRV record - Disabled IMAP service
    srv_imap_disabled = {
      zone_id = var.cloudflare_zone_id
      name    = "_imap._tcp.example.com"
      type    = "SRV"
      ttl     = 600
      data = {
        priority = 0
        weight   = 0
        port     = 0
        target   = "."
      }
    }

    # Example 13: SRV record - Disabled POP3 service
    srv_pop3_disabled = {
      zone_id = var.cloudflare_zone_id
      name    = "_pop3._tcp.example.com"
      type    = "SRV"
      ttl     = 600
      data = {
        priority = 0
        weight   = 0
        port     = 0
        target   = "."
      }
    }

    # Example 14: SRV record - Disabled POP3S service
    srv_pop3s_disabled = {
      zone_id = var.cloudflare_zone_id
      name    = "_pop3s._tcp.example.com"
      type    = "SRV"
      ttl     = 600
      data = {
        priority = 0
        weight   = 0
        port     = 0
        target   = "."
      }
    }
  }
}
