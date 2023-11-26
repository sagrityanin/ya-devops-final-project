terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "./tf_key.json"
  folder_id                = local.folder_id
  zone                     = "ru-central1-a"
}

resource "yandex_vpc_network" "foo" {
  name = "my-net"
}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  route_table_id = yandex_vpc_route_table.rt.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
resource "yandex_vpc_subnet" "ext" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.6.0.0/24"]
}
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}
resource "yandex_vpc_route_table" "rt" {
  name       = "test-route-table"
  network_id = yandex_vpc_network.foo.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}
resource "yandex_container_registry" "registry1" {
  name = "sagrityaninregistry"
  folder_id = local.folder_id
}

locals {
  folder_id = "b1g72ja3gj83ksl68q3h"
  service-accounts = toset([
    "sagrityanin1", "bingo-ig-sa"
  ])
  bingo-sagrityanin1-roles = toset([
    "container-registry.images.puller",
    "container-registry.viewer",
    "monitoring.editor",
    "compute.editor",
    "iam.serviceAccounts.user",
  ])
  bingo-ig-sa-roles = toset([
    "compute.editor",
    "iam.serviceAccounts.user",
    "load-balancer.admin",
    "vpc.publicAdmin",
    "vpc.user",
  ])
}

resource "yandex_iam_service_account" "service-accounts" {
  for_each = local.service-accounts
  name     = "${local.folder_id}-${each.key}"
}
resource "yandex_resourcemanager_folder_iam_member" "bingo-roles" {
  for_each  = local.bingo-sagrityanin1-roles
  folder_id = local.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.service-accounts["sagrityanin1"].id}"
  role      = each.key
}
resource "yandex_resourcemanager_folder_iam_member" "bingo-ig-roles" {
  for_each  = local.bingo-ig-sa-roles
  folder_id = local.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.service-accounts["bingo-ig-sa"].id}"
  role      = each.key
}

data "yandex_compute_image" "coi" {
  family = "container-optimized-image"
}



