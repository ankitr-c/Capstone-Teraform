# ----------------------DEPLOYING VM and FIREWALL RULE---------------------------

# resource "google_compute_instance" "tf_demo" {
#   count          = 3
#   name           = "tf-demo-instance"
#   machine_type   = var.machine_type
#   zone           = var.default_zone
#   tags           = ["port5000", "http-server", "https-server"]
#   can_ip_forward = true
#   boot_disk {
#     initialize_params {
#       image = var.image
#     }
#   }
#   network_interface {
#     network = "default"
#     access_config {

#       # uncomment the below block of code to add static address. 
#       # to add static external ip address you have to manually create and add the address
#       ##   nat_ip = google_compute_address.external_ip.address
#     }
#   }
#   # metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y"

# }

# resource "google_compute_instance" "tf_demo" {
#   count        = length(var.instances)
#   name         = "${var.instances[count.index].name}-${count.index}"
#   machine_type = var.instances[count.index].machine_type
#   zone         = var.instances[count.index].default_zone
#   # tags           = ["port${var.instances[count.index].flask_port}", "http-server", "https-server"]
#   tags = ["http-server", "https-server"]

#   can_ip_forward = true

#   boot_disk {
#     initialize_params {
#       image = var.instances[count.index].image
#       size  = var.instances[count.index].disk_size
#     }
#   }

#   network_interface {
#     network = "default"

#     access_config {}
#   }
# }


# resource "google_compute_instance" "tf_demo" {
#   for_each = {
#     for i in range(2) : tostring(i) => {
#       count = var.instances[i].count
#     }
#   }
#   count = each.key.count
#   # count = length(flatten(length(var.instances) * var.instances.count))
#   # count          = sum([for inst in var.instances : inst.count])
#   name           = "${var.instances[count.index].name}-${count.index}"
#   machine_type   = var.instances[count.index].machine_type
#   zone           = var.instances[count.index].default_zone
#   tags           = ["http-server", "https-server"]
#   can_ip_forward = true

#   boot_disk {
#     initialize_params {
#       image = var.instances[count.index].image
#       size  = var.instances[count.index].disk_size
#     }
#   }

#   network_interface {
#     network = "default"

#     access_config {}
#   }
# }

# --------------------------------------


# resource "google_compute_instance" "tf_demo" {
#   count        = var.instances[1].count
#   name         = "${var.instances[1].name}-${count.index}"
#   machine_type = var.instances[1].machine_type
#   zone         = var.instances[1].default_zone
#   # tags           = ["port${var.instances[count.index].flask_port}", "http-server", "https-server"]
#   tags = ["http-server", "https-server"]

#   can_ip_forward = true

#   boot_disk {
#     initialize_params {
#       image = var.instances[1].image
#       size  = var.instances[1].disk_size
#     }
#   }

resource "google_compute_instance" "tf_demo" {
  count        = length(var.instances) // Use the length of the instances list
  name         = "${var.instances[count.index].name}-${count.index}"
  machine_type = var.instances[count.index].machine_type
  zone         = var.instances[count.index].default_zone
  tags         = ["http-server", "https-server"]

  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = var.instances[count.index].image
      size  = var.instances[count.index].disk_size
    }
  }


  network_interface {
    network = "default"

    access_config {}
  }
}

