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
  family = "service"
  memory = "512"
  cpu = "256"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = aws_iam_role.ecs.arn
  
  container_definitions = jsonencode(
    [{
        "family": "beardedsamwise-weather-app-fam",
        "containerDefinitions": [{
            "name": "beardedsamwise-node-weather-app",
            "image": "152848913167.dkr.ecr.us-east-1.amazonaws.com/beardedsamwise-node-weather-app",
            "portMappings": [{
                "protocol": "tcp",
                "containerPort": 3000
            }],
            "cpu": 0
        }]
    }]
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