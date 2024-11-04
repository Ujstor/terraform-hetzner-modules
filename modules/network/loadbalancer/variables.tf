variable "lb_config" {
  description = "Load balancer configuration."
  type = map(object({
    name               = string
    load_balancer_type = string
    network_zone       = optional(string)
    location           = optional(string)
    algorithm          = optional(string)
    labels             = optional(map(string))
    load_balancer_targets = optional(list(object({
      type             = string #server, label_selector, ip
      load_balancer_id = string
      server_id        = optional(string) #if type server
      label_selector   = optional(map(string))
      ip               = optional(string) #if type ip
      use_private_ip   = optional(bool)   #if type server or label_selector
    })))
    load_balancer_network = optional(list(object({
      load_balancer_id = string
      network_id       = optionsl(string)
      subnet_id        = optional(string)
      ip               = optional(string) #subnet ip
      depends_on       = optional(list(string))
    })))
  }))
}

variable "depended_on_lb_serve_network" {
  description = "subnets that lb depends on"
  type        = optional(list(string))
}
