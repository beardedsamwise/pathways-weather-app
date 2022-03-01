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
  cpu = var.task_cpu
  memory = var.task_mem
  container_definitions = jsonencode(
[
{
    "portMappings": [
    {
        "protocol": "tcp",
        "containerPort": "${var.container_port}"
    }],
    "name": "${var.app_name}",
    "image": "${var.image_id}",   
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
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  depends_on      = [aws_iam_role.ecs, aws_iam_policy.ecs, aws_ecs_task_definition.app]

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "${var.app_name}"
    container_port   = var.container_port
  }

    network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = [var.private_subnet_ids[0], var.private_subnet_ids[1]]
    assign_public_ip = false
  }
}

