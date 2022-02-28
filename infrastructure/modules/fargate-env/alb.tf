# create target group for ALB
resource "aws_lb_target_group" "app" {
  name        = "${var.app_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  tags        = {
      Name = "${var.prefix}-alb-tg"
  }
}

# create application load balancer (ALB)
resource "aws_lb" "app" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [var.public_subnet_ids[0], var.public_subnet_ids[1]]

  tags = {
    Name = "${var.prefix}-alb"
  }
}

# create ALB listener
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

