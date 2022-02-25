# create ECS instances
resource "aws_ecs_cluster" "weather-app" {
  name = "${var.prefix}-weather-app-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# create task definition
resource "aws_ecs_task_definition" "weather-app" {
  family = "${var.prefix}-weather-app-fam"
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
    "name": "weather-app",
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
resource "aws_ecs_service" "weather-app" {
  name            = "weather-app"
  cluster         = aws_ecs_cluster.weather-app.id
  task_definition = aws_ecs_task_definition.weather-app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  depends_on      = [aws_iam_role.ecs, aws_iam_policy.ecs, aws_ecs_task_definition.weather-app]

  load_balancer {
    target_group_arn = aws_lb_target_group.weather-app.arn
    container_name   = "weather-app"
    container_port   = 3000
  }

    network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = [var.private_subnet_ids[0], var.private_subnet_ids[1]]
    assign_public_ip = false
  }
}

