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
# -----------

# module "instance_template" {
#   source       = "terraform-google-modules/vm/google/modules/instance_template"
#   version      = "11.0.0"
#   for_each     = var.vm
#   region       = var.region_name
#   project_id   = var.project_id
#   tags         = var.vm[each.value].tags
#   source_image = var.vm[each.value].source_image
#   disk_size_gb = var.vm[each.value].root_disk_size
#   machine_type = var.vm[each.value].machine_type
#   labels       = merge(var.app.labels, var.vm[count.index].labels)

#   #   metadata = var.vm[each.value].instance_config.os_type == "linux" ? {
#   #     sshKeys                = var.vm[each.value].instance_config.os_type == "linux" ? "${var.vm[count.index].instance_config.gce_user}:${tls_private_key.private_key_pair[count.index].public_key_openssh}" : ""
#   #     block-project-ssh-keys = true
#   #   } : {}

#   service_account = {
#     email  = var.vm[each.value].email
#     scopes = ["cloud-platform"]
#   }
# }


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


# region_name = "us-central1"
# project_id  = "your-project-id"

# vm = {
#   codylitics = {
#     name_prefix   = "tpl-codylitics"
#     tags          = ["http-server", "https-server"]
#     source_image  = "ubuntu-os-cloud/ubuntu-2004-lts"
#     disk_size_gb  = 25
#     machine_type  = "e2-micro"
#     labels = {
#       tag1 = "sample-1"
#       tag2 = "sample-2"
#     }
#     count         = 2
#     default_zone  = "us-central1-a"
#     email         = "ankitraut@gmail.com"
#     additional_disks = {
#       disk_name    = "additional-disk"
#       device_name  = "additional-disk"
#       disk_size_gb = 50
#       disk_type    = "pd-standard"
#     }
#   },
#   stessa = {
#     name_prefix   = "tpl-stessa"
#     tags          = ["http-server", "https-server"]
#     source_image  = "ubuntu-os-cloud/ubuntu-2004-lts"
#     disk_size_gb  = 25
#     machine_type  = "e2-micro"
#     labels = {
#       tag3 = "sample-3"
#       tag4 = "sample-4"
#     }
#     count         = 2
#     default_zone  = "us-central1-b"
#     email         = "ankitraut@gmail.com"
#   }
# }
