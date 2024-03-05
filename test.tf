resource "google_compute_instance" "tf_demo" {
  name           = var.name
  machine_type   = var.machine_type
  zone           = var.default_zone
  tags           = ["port5000", "http-server", "https-server"]
  can_ip_forward = true
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
}
