variable "POSTGRES_PASSWORD" {
  type        = string
  sensitive   = true
  description = "User postgresql password."
}
variable "POSTGRES_USER" {
  type        = string
  sensitive   = true
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
variable "postgres_port" {
  type        = number
  description = "Postgres port."
}
variable "postgres-port" {
  type        = number
  description = "Postgres port."
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
      subnet_id = yandex_vpc_subnet.foo.id
      nat = true
    }
    boot_disk {
      initialize_params {
        type = "network-hdd"
        size = "30"
        image_id = data.yandex_compute_image.coi.id
      }
    }
    metadata = {
      docker-compose = file("${path.module}/../db_host/docker-compose.yaml")
      ssh-keys  = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}