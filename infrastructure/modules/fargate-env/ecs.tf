# create ECS instances
resource "aws_ecs_cluster" "app" {
  name = "${var.prefix}-${var.app_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# create task definition
resource "aws_ecs_task_definition" "app" {
  family = "${var.prefix}-${var.app_name}-fam"
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs.arn
  cpu = 256
  memory = 512
  container_definitions = jsonencode(
[
{
    "portMappings": [
    {
        "protocol": "tcp",
        "containerPort": 3000
    }],
    "name": "${var.app_name}",
    "image": "${var.image_id}",   
    "memory": 512,
    "cpu": 256,
    "requiresCompatibilities": [
        "FARGATE"
    ]
}
]
  )
}

# create ECS service (deploy weather-app container)
resource "aws_ecs_service" "app" {
  name            = "${var.app_name}"
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  depends_on      = [aws_iam_role.ecs, aws_iam_policy.ecs, aws_ecs_task_definition.app]

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "weather-app"
    container_port   = 3000
  }

    network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = [var.private_subnet_ids[0], var.private_subnet_ids[1]]
    assign_public_ip = false
  }
}

