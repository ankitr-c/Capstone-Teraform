# ------------------Instance Template------------------

# This block of module itterates in the var.vm variable using for each loop and \
# creates 1 instance template for each server.

module "instance_template" {
  source       = "terraform-google-modules/vm/google//modules/instance_template"
  version      = "11.0.0"
  for_each     = var.vm
  region       = var.region_name
  project_id   = var.project_id
  name_prefix  = each.value.Instnace.name_prefix
  tags         = each.value.tags
  source_image = each.value.Instnace.source_image
  disk_size_gb = each.value.Instnace.disk_size_gb
  machine_type = each.value.Instnace.machine_type
  network      = "default"
  labels       = merge(each.value.labels)


  service_account = {
    email  = each.value.email
    scopes = ["cloud-platform"]
  }
  additional_disks = each.value.Instnace.additional_disks != null ? [
    {
      disk_name    = each.value.Instnace.additional_disks.disk_name
      device_name  = each.value.Instnace.additional_disks.device_name
      disk_size_gb = each.value.Instnace.additional_disks.disk_size_gb
      disk_type    = each.value.Instnace.additional_disks.disk_type
      auto_delete  = true
      boot         = false
      disk_labels  = {}
    }
  ] : []
}

# ------------------Number Of Req Servers------------------

# This locals block creates a variable named server_count i.e the type of list of list, \
# and will store the name of each server and the count of instances for each server.
# example:
# [
#   ["codylitics", 2],
#   ["stessa", 3]
# ]

locals {
  server_count = [
    for idx, instance_config in var.vm : [idx, instance_config.Instnace.count]
  ]
}

# ------------------Creating Instances For Each Servers------------------

#This block of module itterates for the length of instance templates, i.e. total number of instance templates, \
# it feteches the appropriate instance_template using the 0th index of server_count variable
# number of instance for each server using 1st index of server_count, \
# and creates the required number of instances for each server.

module "compute_instance" {
  source              = "terraform-google-modules/vm/google//modules/compute_instance"
  version             = "11.0.0"
  count               = length(module.instance_template)
  region              = var.region_name
  hostname            = local.server_count[count.index][0]
  instance_template   = tostring(module.instance_template[local.server_count[count.index][0]].self_link)
  deletion_protection = false
  network             = "default"
  num_instances       = local.server_count[count.index][1]
  # add_hostname_suffix = false
}

