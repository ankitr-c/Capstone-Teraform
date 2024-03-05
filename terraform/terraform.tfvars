project_id  = "proven-answer-414613"
region_name = "us-east4"

instances = [
  {
    count        = 2
    name         = "codylitics-instance"
    machine_type = "e2-micro"
    disk_size    = 10
    # flask_port   = 5000
    default_zone = "us-east4-a"
    image        = "ubuntu-os-cloud/ubuntu-2004-lts"
  },
  {
    count        = 3
    name         = "stessa-instance"
    machine_type = "e2-micro"
    disk_size    = 10
    # flask_port   = 5000
    default_zone = "us-east4-a"
    image        = "ubuntu-os-cloud/ubuntu-2004-lts"
  }
]

# {
# codylitics = {
#     count  = 2 
#     dsk_zise = 20
# }
# stessa = {
#     count = 5
#     disk_size = 12
# }
# }

