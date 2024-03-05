variable "project_id" {
  description = "this is the default project id"
}

variable "region_name" {
  description = "this is the default region"
}

# variable "counter" {
#   description = "simple-counter"
#   default     = 0

# }
# variable "image" {
#   description = "default ubuntu image"
# }

# variable "machine_type" {
#   description = "this is the default machine type"
# }

# variable "flask_port" {
#   description = "this is the default python flask port number"
# }

# variable "default_zone" {
#   description = "this is the default zone for us-east4 || us-east4-a"
# }

variable "instances" {
  description = "List of instances to create"
  type = list(object({
    count        = number
    name         = string
    machine_type = string
    disk_size    = number
    # flask_port   = number
    default_zone = string
    image        = string
  }))
}



# variable "instances" {
#   description = "List of instances to create"
#   type = list(object({
#     count        = number
#     name         = string
#     machine_type = string
#     disk_size    = number
#     flask_port   = number
#     default_zone = string
#     image        = string
#   }))
# }
