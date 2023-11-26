resource "yandex_compute_instance_group" "bingo-worker-group" {
  name = "bingo-worker-group"
  depends_on = [
    yandex_resourcemanager_folder_iam_member.bingo-ig-roles
  ]
  service_account_id = yandex_iam_service_account.service-accounts["bingo-ig-sa"].id
  instance_template {
    platform_id = "standard-v2"
    name = "bingo-worker-{instance.short_id}"
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
      network_id = yandex_vpc_network.foo.id
      subnet_ids = ["${yandex_vpc_subnet.foo.id}"]
      nat = false
      security_group_ids = ["${yandex_vpc_security_group.group1.id}",]
    }
    scheduling_policy {
      preemptible = true
    }
    service_account_id = yandex_iam_service_account.service-accounts["sagrityanin1"].id

    metadata = {
      docker-compose = templatefile(
        "${path.module}/../docker-compose.yaml",
        {
          folder_id   = "${local.folder_id}",
          registry_id = "${yandex_container_registry.registry1.id}",
        }
      )
      user-data = file("${path.module}/cloud-config.yaml")
      ssh-keys  = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
  }
  scale_policy {
    fixed_scale {
      size = 2
    }
  }
  allocation_policy {
    zones = ["ru-central1-a"]
  }
  deploy_policy {
    max_unavailable = 2
    max_creating = 2
    max_expansion = 2
    max_deleting = 2
  }
  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }
}
