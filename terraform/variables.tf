#--------------------Variable For Project ID--------------------------
variable "project_id" {
  description = "this is the default project id"
}

#--------------------Variable For Region Name--------------------------
variable "region_name" {
  description = "this is the default region"
}

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
