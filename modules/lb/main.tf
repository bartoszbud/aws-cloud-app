data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-vpc"]
  }
}

data "aws_instance" "main" {
  for_each = var.ec2_instances
  filter {
    name = "tag:Name"
    values = [each.key]
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

data "aws_security_group" "firewall_rules" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-security-group"]
  }

  vpc_id = data.aws_vpc.vpc.id
}
 

resource "aws_lb" "external-alb" {
  name               = "CloudApp-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.firewall_rules.id]
  subnets            = [for subnet in data.aws_subnet.public_subnet : subnet.id]
}

resource "aws_lb_target_group" "target_elb" {
  name        = "elb-${var.environment}-target"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"
  health_check {
    path                = "/health"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "main" {
  for_each = data.aws_instance.main
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = data.aws_instance.main[each.key].private_ip
  port             = 80
  depends_on = [
    aws_lb_target_group.target_elb
  ]
}

resource "aws_lb_listener" "listener_elb" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_elb.arn
  }
}