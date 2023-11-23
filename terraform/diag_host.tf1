resource "yandex_compute_instance" "monitor-host" {
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
      subnet_id = "${yandex_vpc_subnet.foo.id}"
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
      ssh-keys  = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}
