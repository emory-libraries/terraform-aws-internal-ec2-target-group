resource "aws_alb_target_group" "target_group" {
  name     = "${local.namespace}-alb-${var.ec2_common_name}"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 1800
    enabled         = "true"
  }
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 30
    path                = "/"
    port                = "80"
  }
}


# Web listener rule and target group
resource "aws_lb_listener_rule" "alb_web_listener_rule" {
  listener_arn = var.alb_listener_arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }

  condition {
    host_header {
      values = [local.appended_fqdn]
    }
  }
}

resource "aws_alb_target_group_attachment" "alb_ec2" {
  target_group_arn = aws_alb_target_group.target_group.arn
  target_id        = aws_instance.ec2.id
  port             = 80
}