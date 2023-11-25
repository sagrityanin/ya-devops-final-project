resource "yandex_vpc_security_group" "group1" {
  name        = "My security group"
  description = "description for my security group"
  network_id  = "${yandex_vpc_network.foo.id}"
  labels = {
    my-label = "bingo-sg"
  }
  ingress {
    description = "Allow Inbound HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Inbound HTTP"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Inbound ssh"
    port   = 22
    protocol    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Inbound ssh"
    port   = 8000
    protocol    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow in postgresql connection"
    port   = 5432
    protocol    = "tcp"
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  egress {
    description = "Allow out postgresql connection"
    port   = 5432
    protocol    = "tcp"
    v4_cidr_blocks = ["10.5.0.0/24"]
  }
  egress {
    description = "Allow out https connection"
    port   = 443
    protocol    = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow out http connection"
    port   = 80
    protocol    = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow out http connection"
    port   = 8000
    protocol    = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "test"
    port   = 80
    protocol    = "Tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "test"
    port = 443
    protocol    = "Tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "dns"
    port   = 53
    protocol    = "Udp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "cloud"
    port   = 68
    protocol    = "Udp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "cloud2"
    port   = 58
    protocol    = "Any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    description = "helthcheck"
    port   = 8000
    protocol    = "Any"
    v4_cidr_blocks = ["198.18.235.0/24", "198.18.248.0/24"]
  } 
  ingress {
    protocol       = "ICMP"
    description    = "Rule allows debugging ICMP packets from internal subnets."
    v4_cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"]
  }
  egress {
    protocol       = "ICMP"
    description    = "Rule allows debugging ICMP packets from out subnets."
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
