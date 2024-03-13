variable "project_id" {
  description = "this is the default project id"
}

variable "region_name" {
  description = "this is the default region"
}


# variable "vm" {
#   description = "Map of VM configurations"
#   type = map(object({
#     name_prefix  = string
#     tags         = list(string)
#     source_image = string
#     disk_size_gb = number
#     machine_type = string
#     labels       = map(string)
#     count        = number
#     default_zone = string
#     email        = string
#     additional_disks = optional(object({
#       disk_name    = string
#       device_name  = string
#       disk_size_gb = number
#       disk_type    = string
#     }))
#   }))
# }


variable "vm" {
  description = "Map of VM configurations"
  type = map(object({
    tags   = list(string)
    labels = map(string)
    email  = string
    Instnace = object({
      source_image = string
      name_prefix  = string
      count        = number
      default_zone = string
      disk_size_gb = number
      machine_type = string
      additional_disks = optional(object({
        disk_name    = string
        device_name  = string
        disk_size_gb = number
        disk_type    = string
      }))
    })
  }))
}
