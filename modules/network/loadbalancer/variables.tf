variable "lb_config" {
  description = "Load balancer configuration."
  type = map(object({
    name               = string
    load_balancer_type = string
    network_zone       = optional(string)
    location           = optional(string) #Require when no network_zone is set
    algorithm          = optional(object({ type = string }))
    labels             = optional(map(string))
    load_balancer_targets = optional(list(object({
      type           = string           #server, label_selector, ip
      server_id      = optional(string) #if type server
      label_selector = optional(string)
      ip             = optional(string) #if type ip
      use_private_ip = optional(bool)   #if type server or label_selector
    })))
    load_balancer_network = optional(list(object({
      #Use depends_on to make sure the network is created before the load balancer
      network_id = optional(string) #or network id or subnet id
      subnet_id  = optional(string)
      ip         = optional(string) #subnet ip
    })))
  }))
}
