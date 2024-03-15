#--------------------Project ID Value--------------------------
project_id = "proven-answer-414613"

#--------------------Region Name Value-------------------------
region_name = "us-east4"

#-----------------------VM Req Value---------------------------
vm = {
  # Block With Additional Disk
  codylitics = {
    tags   = ["http-server", "https-server"]
    labels = { "lable1" = "sample-1", "lable2" = "sample-2" }
    email  = "300186963124-compute@developer.gserviceaccount.com"

    Instnace = {
      source_image = ""
      name_prefix  = "tpl-codylitics"
      count        = 2
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
    # Block Without Additional Disk
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
