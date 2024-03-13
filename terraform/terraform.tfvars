project_id  = "proven-answer-414613"
region_name = "us-east4"

# -------------------------------------
vm = {
  codylitics = {
    tags   = ["http-server", "https-server"]
    labels = { "lable1" = "sample-1", "lable2" = "sample-2" }
    email  = "300186963124-compute@developer.gserviceaccount.com"

    Instnace = {
      source_image = ""

      name_prefix  = "tpl-codylitics"
      count        = 1
      default_zone = "us-east4-a"

      disk_size_gb = 25
      machine_type = "e2-micro"

      additional_disks = {
        disk_name    = "additional-disk"
        device_name  = "additional-disk"
        disk_size_gb = 10
        disk_type    = "pd-standard"
      }
    }
  }

  stessa = {
    tags   = ["http-server", "https-server"]
    labels = { "lable3" = "sample-3", "lable4" = "sample-4" }
    email  = "300186963124-compute@developer.gserviceaccount.com"

    Instnace = {
      source_image = ""

      name_prefix  = "tpl-stessa"
      count        = 2
      default_zone = "us-east4-a"

      disk_size_gb = 25
      machine_type = "e2-micro"
    }
  }
}

# ----------old----------

# vm = {
#   codylitics = {
#     name_prefix  = "tpl-codylitics"
#     tags         = ["http-server", "https-server"]
#     source_image = ""

#     count        = 1
#     default_zone = "us-east4-a"
#     email        = "300186963124-compute@developer.gserviceaccount.com"

#     disk_size_gb = 25
#     machine_type = "e2-micro"
#     labels = { "tag1" = "sample-1",
#       "tag2" = "sample-2"
#     }
#     additional_disks = {
#       disk_name    = "additional-disk"
#       device_name  = "additional-disk"
#       disk_size_gb = 10
#       disk_type    = "pd-standard"
#     }

#   }
#   stessa = {
#     name_prefix  = "tpl-stessa"
#     tags         = ["http-server", "https-server"]
#     source_image = ""

#     count        = 2
#     default_zone = "us-east4-a"
#     email        = "300186963124-compute@developer.gserviceaccount.com"

#     disk_size_gb = 25
#     machine_type = "e2-micro"
#     labels = { "tag3" = "sample-3",
#       "tag4" = "sample-4"
#     }

#   }
# }


# source_image = "ubuntu-os-cloud/ubuntu-2004-lts"

# stessa = {
#   count        = 3
#   machine_type = "e2-micro"
#   disk_size    = 10
#   default_zone = "us-east4-a"
#   image        = "ubuntu-os-cloud/ubuntu-2004-lts"
#   email        = "ankitraut@gmail.com"

# }
# lnd-onev = {
#   count        = 5
#   machine_type = "e2-micro"
#   disk_size    = 10
#   default_zone = "us-east4-a"
#   image        = "ubuntu-os-cloud/ubuntu-2004-lts"
#   email        = "ankitraut@gmail.com"
# }



#vm = {
# codylitics = {
#     count  = 2 
#     dsk_zise = 20
# }
# stessa = {
#     count = 5
#     disk_size = 12
# }
# }

