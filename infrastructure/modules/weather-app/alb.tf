# create target group for ALB
resource "aws_lb_target_group" "weather-app" {
  name        = "weather-app-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  tags        = {
      Name = "${var.prefix}-alb-tg"
  }
}

# create application load balancer (ALB)
resource "aws_lb" "weather-app" {
  name               = "weather-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [var.public_subnet_id_0, var.public_subnet_id_1]

  enable_deletion_protection = true

  tags = {
    Name = "${var.prefix}-alb"
  }
}

# # create data source to get latest Amazon Linux 2 AMI ID
# data "aws_ami" "amzn2" {
#   most_recent = true
#   owners = ["amazon"]
#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#     }

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm*"]
#     }
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#     }
# }

# # create launch configuration
# resource "aws_launch_configuration" "weather-app" {
#   name_prefix   = "weather-app-"
#   image_id      = data.aws_ami.amzn2.id
#   instance_type = "t3.small"
#   associate_public_ip_address = false
#   security_groups = [aws_security_group.ecs.id]

#   lifecycle {
#     create_before_destroy = true
#   }
# }
