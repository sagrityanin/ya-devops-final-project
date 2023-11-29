variable "listeners" {
  description = "Network load balancer listeners"
  type        = list
  default = [
    {
      name        = "listen443",
      port        = 443,
      target_port = 443,
      protocol    = "tcp",
    },
    {
      name        = "listen80",
      port        = 80,
      target_port = 80,
      protocol    = "tcp",
    }
  ]
}

resource "yandex_lb_network_load_balancer" "foo" {
  name = "sagrityanin-lb"
  deletion_protection = "false"
  type = "internal"
  dynamic "listener" {
    for_each = var.listeners
    content {
      name                  = listener.value["name"]
      port                  = listener.value["port"]
      target_port           = listener.value["target_port"]
      protocol              = listener.value["protocol"]
      internal_address_spec {
        ip_version = "ipv4"
        subnet_id = yandex_vpc_subnet.foo.id
      }
    }
  }
  attached_target_group {
    target_group_id = yandex_compute_instance_group.bingo-worker-group.load_balancer.0.target_group_id
    healthcheck {
      name = "bingo-check"
      interval            = 2
      timeout             = 1
      unhealthy_threshold = 2
      healthy_threshold   = 2
      http_options {
        port = 8000
        path = "/api/movie"
      }
    }
  }
}
