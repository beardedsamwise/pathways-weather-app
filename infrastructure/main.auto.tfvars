bucket   = "dojoweatherapp-sam"
prefix   = "sam-b"
az       = ["us-east-1a", "us-east-1b", "us-east-1c"]
vpc_cidr = "10.0.0.0/16"
tags = {
  Owner   = "Sam Bentley"
  Project = "Dojo Weather App"
}
subnets_public = [
  {
    name = "public-a"
    cidr = "10.0.0.0/28"
  },
  {
    name = "public-b"
    cidr = "10.0.1.0/28"
  },
  {
    name = "public-c"
    cidr = "10.0.2.0/28"
  },
]
subnets_private = [
  {
    name = "private-a"
    cidr = "10.0.50.0/26"
  },
  {
    name = "private-b"
    cidr = "10.0.51.0/26"
  },
  {
    name = "private-c"
    cidr = "10.0.52.0/26"
  },
]
git_username   = "beardedsamwise"
image_id       = "152848913167.dkr.ecr.us-east-1.amazonaws.com/beardedsamwise-node-weather-app:1"
app_name       = "weather-app"
container_port = 3000
task_mem       = 512
task_cpu       = 256
desired_count  = 2
domain         = "beardedsamwise.co"