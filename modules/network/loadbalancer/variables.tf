variable "lb_config" {
  description = "Load balancer configuration."
  type = map(object({
    name               = string
    load_balancer_type = string
    network_zone       = optional(string)
    location           = optional(string) #Require when no network_zone is set
    delete_protection  = optional(bool, false)
    algorithm          = optional(object({ type = string }))
    labels             = optional(map(string))
    load_balancer_targets = optional(list(object({
      type           = string           #server, label_selector, ip
      server_id      = optional(string) #if type server
      label_selector = optional(string)
      ip             = optional(string) #if type ip
      use_private_ip = optional(bool)   #if type server or label_selector
    })))
    load_balancer_network = optional(object({
      #Use depends_on to make sure the network is created before the load balancer
      network_id              = optional(string)       #or network id or subnet id
      subnet_id               = optional(string)
      ip                      = optional(string)       #subnet ip
      enable_public_interface = optional(bool, true)   #disable public interface for private-only LB
    }))
    load_balancer_service = optional(list(object({
      protocol         = optional(string)
      listen_port      = optional(number)
      destination_port = optional(number)
      proxyprotocol    = optional(bool)
      health_check = optional(object({
        protocol = string                              #http, https, tcp
        port     = number
        interval = optional(number, 15)                #seconds
        timeout  = optional(number, 10)                #seconds
        retries  = optional(number, 3)
        http = optional(object({
          domain       = optional(string)
          path         = optional(string, "/")
          response     = optional(string)
          tls          = optional(bool)
          status_codes = optional(list(string), ["2??", "3??"])
        }))
      }))
      http = optional(object({
        sticky_sessions = optional(bool)
        cookie_name     = optional(string)
        cookie_lifetime = optional(number)
        certificates    = optional(list(string))
        redirect_http   = optional(bool)
      }))
    })))
  }))
}
