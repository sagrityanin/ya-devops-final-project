resource "yandex_lb_network_load_balancer" "foo" {
  name = "sagrityanin-lb"
  
  deletion_protection = "false"
  listener {
    name = "bingo"
    port = 80
    target_port = 8000
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
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
        path = "/"
      }
    }
  }
}
