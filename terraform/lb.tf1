resource "yandex_lb_network_load_balancer" "foo" {
  name = "sagrityanin-lb"
  
  deletion_protection = "false"
  listener {
    name = "catgpt"
    port = 80
    target_port = 8080
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_compute_instance_group.catgpt-group.load_balancer.0.target_group_id
    healthcheck {
      name = "catgptcheck"
      interval            = 2
      timeout             = 1
      unhealthy_threshold = 2
      healthy_threshold   = 2
      http_options {
        port = 8080
        path = "/"
      }
    }
  }
}
