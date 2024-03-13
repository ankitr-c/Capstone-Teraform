
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

locals {
  template_names = {
    for idx, instance_config in var.vm : var.vm[idx].Instnace.name_prefix => {
      name = module.instance_template[idx].self_link
    }
  }
}


locals {
  exploded_vm = merge([
    for instance_name, instance_config in var.vm : {
      for i in range(instance_config.Instnace.count) : "${instance_name}-${i + 1}" => {
        template_name = instance_name
      }
    }
  ]...)
}


module "compute_instance" {
  source            = "terraform-google-modules/vm/google//modules/compute_instance"
  version           = "11.0.0"
  for_each          = local.exploded_vm
  region            = var.region_name
  hostname          = each.key #each.value.machine_name 
  instance_template = tostring(local.template_names[var.vm[each.value.template_name].Instnace.name_prefix].name)
  # instance_template   = tostring(each.value.template_name)
  deletion_protection = false
  network             = "default"

}
# hostname            = each.key

