data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

data "aws_subnet" "public_subnet" {
  for_each = var.ec2_instances

  filter {
    name   = "tag:Name"
    values = ["${var.environment}-${each.value.subnet_name}"]
  }
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_security_group" "firewall_rules" {
  name        = "${var.network_name}-allow"
  description = "Allow rules for ${var.network_name}"
  vpc_id      = data.aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.allow_firewall_rules
    content {
      from_port   = (ingress.value.protocol == "icmp") ? 0 : tonumber(lookup(ingress.value, "ports", [0])[0])
      to_port     = (ingress.value.protocol == "icmp") ? 0 : tonumber(lookup(ingress.value, "ports", [0])[0])
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.source_ip_ranges
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-security-group"
  }
}

resource "aws_network_interface" "main" {
  for_each        = var.ec2_instances
  subnet_id       = data.aws_subnet.public_subnet[each.key].id
  private_ips     = [cidrhost(data.aws_subnet.public_subnet[each.key].cidr_block, each.value.ip_host)]
  security_groups = [aws_security_group.firewall_rules.id]
}

resource "aws_key_pair" "aws-ec2" {
  key_name   = "aws-ec2"
  public_key = file("${path.module}/ssh/aws-ec2.pub")
}

resource "aws_instance" "main" {
  for_each          = var.ec2_instances
  ami               = var.ami_id
  instance_type     = each.value.instance_type
  availability_zone = each.value.availability_zone
  key_name          = aws_key_pair.aws-ec2.key_name

  tags = {
    Name        = each.key
    Description = try(each.value.instance_description, null)
  }

  user_data = <<-EOF
              #!/bin/bash

              echo "Aktualizacja pakietów..."
              apt-get update -y

              echo "Instalacja narzędzi do analizy sieci (net-tools)..."
              apt-get install -y net-tools

              echo "Instalacja nginx"
              apt-get install -y nginx

              echo "Modyfikacja pliku index.html"
              sudo chmod 777 /var/www/html/index.nginx-debian.html
              mv /var/www/html/index.nginx-debian.html /var/www/html/index.html 
              echo "<h1>Witaj na stronie CloudApp - $HOSTNAME</h1>" > /var/www/html/index.html
              sudo chmod 644 /var/www/html/index.html
              EOF

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.main[each.key].id
  }
}