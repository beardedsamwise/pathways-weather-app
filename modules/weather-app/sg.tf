# create security groups for ECS and ALB
resource "aws_security_group" "alb" {
  name        = "weather-app-alb-sg"
  description = "weather-app-alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-alb-sg"
  }
}

resource "aws_security_group" "ecs" {
  name        = "weather-app-ecs-sg"
  description = "weather-app-ecs-sg"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb.id]
  }

  tags = {
    Name = "${var.prefix}-ecs-sg"
  }
}