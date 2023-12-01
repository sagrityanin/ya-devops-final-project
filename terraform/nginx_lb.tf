resource "yandex_compute_instance" "bingo-nlb" {
  depends_on = [
    yandex_compute_instance_group.bingo-worker-group
  ]
  platform_id = "standard-v2"
  name = "bingo-nginx-nlb"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      type = "network-hdd"
      size = "30"
      image_id = data.yandex_compute_image.coi.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.foo.id
    
    nat = true
    security_group_ids = ["${yandex_vpc_security_group.group1.id}",]
  }
  scheduling_policy {
    preemptible = true
  }
  service_account_id = yandex_iam_service_account.service-accounts["sagrityanin1"].id

  metadata = {
    docker-compose = templatefile(
      "${path.module}/../nginx_lb/docker-compose.yaml",
      {
        folder_id   = "${local.folder_id}",
        registry_id = "${yandex_container_registry.registry1.id}",
      }
    )
    user-data = file("${path.module}/cloud-config.yaml")
    ssh-keys  = "andrey:${file("~/.ssh/id_rsa.pub")}"
  }
}

output "Nginx_lb_ip" {
  value = yandex_compute_instance.bingo-nlb.network_interface[0].nat_ip_address
}