terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-b"
}
data "yandex_compute_image" "last_ubuntu" {
  family = "ubuntu-2204-lts" # ОС (Ubuntu, 22.04 LTS)
}
data "yandex_vpc_subnet" "default_b" {
  name = "subnet"
}
resource "yandex_compute_instance" "vm1" {
  name = "vm-from-last-ubuntu"

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores         = 2 # vCPU
    memory        = 2 # RAM
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.last_ubuntu.id
    }
  }
  network_interface {
    subnet_id = data.yandex_vpc_subnet.default_b.subnet_id
    nat       = true # автоматически установить динамический ip
  }
  
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/ubuntu.pub")}"
  }
}

