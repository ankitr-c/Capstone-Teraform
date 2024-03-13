# locals {
#   exploded_vm = merge([
#     for instance_name, instance_config in var.vm : {
#       for i in range(instance_config.count) : "${instance_name}-${i}" => {
#         name = instance_name
#       }
#     }
#   ]...)
# }

# 1. The `locals` block in Terraform is used to declare local values that can be referenced within the module.

# 2. `exploded_vm` is a local value that we are defining here. It will be a map containing information about each instance, where the key is the instance name appended with the index (`"${instance_name}-${i}"`) and the value is a map containing the instance name.

# 3. Inside the `merge` function, we have a list comprehension using the `for` expression. This comprehension generates a list of maps where each map represents an instance and its associated configuration.

# 4. The `merge` function is used to merge all the maps generated by the list comprehension into a single map. It takes a list of maps as arguments and merges them into a single map.

# 5. The `...` operator (triple dot) is used to spread the elements of the list generated by the list comprehension as individual arguments to the `merge` function. This is required because the `merge` function expects multiple arguments, each representing a map, but the list comprehension returns a list of maps. The `...` operator allows us to pass each map in the list as a separate argument to the `merge` function.

# In summary, this code generates a map (`exploded_vm`) containing information about each instance, where the key is a unique identifier (`"${instance_name}-${i}"`) and the value is a map containing the instance name. The `merge` function is used to merge all these maps into a single map.

##################### WORKING BLOCK START #####################

# ## NOT WITH INSTANCE GROUP
# locals {
#   exploded_vm = merge([
#     for instance_name, instance_config in var.vm : {
#       for i in range(instance_config.count) : "${instance_name}-${i + 1}" => {
#         name = instance_name
#       }
#     }
#   ]...)
# }

# resource "google_compute_instance" "vm_instances" {
#   for_each     = local.exploded_vm
#   name         = each.key
#   machine_type = var.vm[each.value.name].machine_type
#   zone         = var.vm[each.value.name].default_zone

#   boot_disk {
#     initialize_params {
#       image = var.vm[each.value.name].image
#       size  = var.vm[each.value.name].disk_size
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {}
#   }

# }

##################### WORKING BLOCK END #####################

########### Instance Template ############
# module "instance_template" {
#   source             = "terraform-google-modules/vm/google/modules/instance_template"
#   version            = "11.0.0"
#   count              = length(var.vm)
#   region             = var.config.region
#   project_id         = var.config.project
#   tags               = var.vm[count.index].tags
#   source_image       = var.vm[count.index].instance_config.source_image
#   disk_size_gb       = var.vm[count.index].instance_config.root_disk_size
#   machine_type       = var.vm[count.index].instance_config.machine_type
#   subnetwork         = var.network.subnet
#   subnetwork_project = var.network.project
#   labels             = merge(var.app.labels, var.vm[count.index].labels)

#   metadata = var.vm[count.index].instance_config.os_type == "linux" ? {
#     sshKeys                = var.vm[count.index].instance_config.os_type == "linux" ? "${var.vm[count.index].instance_config.gce_user}:${tls_private_key.private_key_pair[count.index].public_key_openssh}" : ""
#     block-project-ssh-keys = true
#   } : {}

#   service_account = {
#     email  = module.service_accounts[count.index].email
#     scopes = ["cloud-platform"]
#   }
#   additional_disks = [
#     {
#       disk_name    = var.vm[count.index].instance_config.additional_disk_name
#       device_name  = var.vm[count.index].instance_config.additional_disk_name
#       disk_size_gb = var.vm[count.index].instance_config.additional_disk_size
#       disk_type    = var.vm[count.index].instance_config.additional_disk_type
#       auto_delete  = true
#       boot         = false
#       disk_labels  = {}
#     }
#   ]
# }

# ########### Compute Instance ############

# module "compute_instance" {
#   source              = "terraform-google-modules/vm/google/modules/compute_instance"
#   version             = "~>9.0.0"
#   count               = length(module.instance_template)
#   region              = var.config.region
#   zone                = var.zone == null ? data.google_compute_zones.available.names[count.index % length(data.google_compute_zones.available.names)] : var.zone
#   hostname            = "${var.app.env}-${var.vm[count.index].name}"
#   instance_template   = tostring(local.instance_template[count.index])
#   deletion_protection = false
#   subnetwork          = var.network.subnet
#   subnetwork_project  = var.network.project
# }


# locals {
#   instance_template = [for i in module.instance_template : i.self_link]
# }


# ------------------------Experimental Work--------------------------


# module "instance_template" {
#   source       = "terraform-google-modules/vm/google//modules/instance_template"
#   version      = "11.0.0"
#   for_each     = var.vm
#   region       = var.region_name
#   project_id   = var.project_id
#   name_prefix  = var.vm[each.key].name_prefix
#   tags         = var.vm[each.key].tags
#   source_image = var.vm[each.key].source_image
#   disk_size_gb = var.vm[each.key].disk_size_gb
#   machine_type = var.vm[each.key].machine_type
#   network      = "default"
#   labels       = merge(var.vm[each.key].labels)


#   service_account = {
#     email  = var.vm[each.key].email
#     scopes = ["cloud-platform"]
#   }
#   additional_disks = each.value.additional_disks != null ? [
#     {
#       disk_name    = each.value.additional_disks.disk_name
#       device_name  = each.value.additional_disks.device_name
#       disk_size_gb = each.value.additional_disks.disk_size_gb
#       disk_type    = each.value.additional_disks.disk_type
#       auto_delete  = true
#       boot         = false
#       disk_labels  = {}
#     }
#   ] : []
# }


module "instance_template" {
  source       = "terraform-google-modules/vm/google//modules/instance_template"
  version      = "11.0.0"
  for_each     = var.vm
  region       = var.region_name
  project_id   = var.project_id
  name_prefix  = each.value.name_prefix
  tags         = each.value.tags
  source_image = each.value.source_image
  disk_size_gb = each.value.disk_size_gb
  machine_type = each.value.machine_type
  network      = "default"
  labels       = merge(each.value.labels)


  service_account = {
    email  = each.value.email
    scopes = ["cloud-platform"]
  }
  additional_disks = each.value.additional_disks != null ? [
    {
      disk_name    = each.value.additional_disks.disk_name
      device_name  = each.value.additional_disks.device_name
      disk_size_gb = each.value.additional_disks.disk_size_gb
      disk_type    = each.value.additional_disks.disk_type
      auto_delete  = true
      boot         = false
      disk_labels  = {}
    }
  ] : []
}

# name_prefix  = var.vm[each.key].name_prefix
# tags         = var.vm[each.key].tags
# source_image = var.vm[each.key].source_image
# disk_size_gb = var.vm[each.key].disk_size_gb
# machine_type = var.vm[each.key].machine_type

locals {
  template_names = {
    for idx, instance_config in var.vm : var.vm[idx].name_prefix => {
      name = module.instance_template[idx].self_link
    }
  }
}


locals {
  exploded_vm = merge([
    for instance_name, instance_config in var.vm : {
      for i in range(instance_config.count) : "${instance_name}-${i + 1}" => {
        template_name = instance_name
        # machine_name  = instance_name
      }
    }
  ]...)
}


module "compute_instance" {
  source              = "terraform-google-modules/vm/google//modules/compute_instance"
  version             = "11.0.0"
  for_each            = local.exploded_vm
  region              = var.region_name
  hostname            = each.key #each.value.machine_name 
  instance_template   = tostring(local.template_names[var.vm[each.value.template_name].name_prefix].name)
  deletion_protection = false
  network             = "default"

}
# hostname            = each.key

