variable "volume_config" {
  description = "Volume configuration"
  type = map(object({
    size = number
    location = string
    server_id = string
  }))
  }

variable "volume_format" {
  description = "Format volume after creation (xfs or ext4)"
  type = string
  default = "xfs"
}
