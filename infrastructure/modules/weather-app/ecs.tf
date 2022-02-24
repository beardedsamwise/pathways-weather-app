# create ECS instances
resource "aws_ecs_cluster" "weather-app" {
  name = "${var.prefix}-weather-app-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# create task definition
resource "aws_ecs_task_definition" "service" {
  family = "${var.prefix}-weather-app-fam"

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
    ],
    "networkMode": "awsvpc",
    "executionRoleArn": "${aws_iam_role.ecs.arn}"
}
]
  )
}

# create ECS service
# resource "aws_ecs_service" "weather-app" {
#   name            = "weather-app-service"
#   cluster         = aws_ecs_cluster.weather-app.id
#   #task_definition = aws_ecs_task_definition.mongo.arn
#   desired_count   = 3
#   iam_role        = aws_iam_role.ecs.arn
#   depends_on      = [aws_iam_policy.ecs]

#   load_balancer {
#     target_group_arn = aws_lb_target_group.weather-app.arn
#     container_name   = "weather-app"
#     container_port   = 3000
#   }
# }