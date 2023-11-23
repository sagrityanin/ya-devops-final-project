resource "yandex_vpc_security_group" "group1" {
  name        = "My security group"
  description = "description for my security group"
  network_id  = "${yandex_vpc_network.foo.id}"
  labels = {
    my-label = "catgpt-sg"
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
  egress {
    description = "out "
    from_port   = 0
    to_port     = 65535
    protocol    = "Any"
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
    protocol       = "ICMP"
    description    = "Rule allows debugging ICMP packets from internal subnets."
    v4_cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"]
  }
}
