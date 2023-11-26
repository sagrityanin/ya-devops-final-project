variable "POSTGRES_PASSWORD" {
  type        = string
  description = "User postgresql password."
}
variable "POSTGRES_USER" {
  type        = string
  description = "Postgres user name."
}
variable "POSTGRES_DB" {
  type        = string
  description = "Postgres database name."
}
variable "POSTGRES_HOST" {
  type        = string
  description = "Postgresql host name."
}
variable "POSTGRES_PORT" {
  type        = string
  description = "Postgresql host name."
}
variable "private_key_path" {
  description = "Path to ssh private key, which would be used to access workers"
  default     = "~/.ssh/id_rsa"
}

resource "yandex_compute_instance" "bingo-db" {
  platform_id        = "standard-v2"
  service_account_id = yandex_iam_service_account.service-accounts["sagrityanin1"].id
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    security_group_ids = ["${yandex_vpc_security_group.group1.id}",]
    subnet_id = yandex_vpc_subnet.foo.id
    nat = false
  }
  name = "bingo-db"
  boot_disk {
    initialize_params {
      type = "network-hdd"
      size = "30"
      image_id = data.yandex_compute_image.coi.id
    }
  }
  metadata = {
    test-var: "${var.POSTGRES_DB}"
    docker-compose = templatefile(
      "${path.module}/../db_host/docker-compose.yaml",
      {
        folder_id   = "${local.folder_id}",
        registry_id = "${yandex_container_registry.registry1.id}",
        POSTGRES_PASSWORD = "${var.POSTGRES_PASSWORD}"
        POSTGRES_USER     = "${var.POSTGRES_USER}"
        POSTGRES_DB       = "${var.POSTGRES_DB}"
      }
    )
    ssh-keys  = "ubuntu:${file("~/.ssh/id_rsa.pub")}"     
  }
}
