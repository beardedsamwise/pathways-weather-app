### Define Variables
variable "prefix" {
  default     = "dojostudent"
}

variable "subnets_public" {
  description = "Object list of public subnets for deployment"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "subnets_private" {
  description = "Object list of private subnets for deployment"
  type = list(object({
    name = string
    cidr = string
  }))
}

variable "az" {
  description = "List of availability zones to deploy subnets to"
  type        = list(string)
}

### Create resources

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    "Name" = "${var.prefix}_vpc"
  }
}

# For each type of subnet, ensure the number of AZs matches 
# the number of subnets that you're trying to create        

# create public subnets 
resource "aws_subnet" "public" {
  count = length(var.az)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets_public[count.index].cidr
  availability_zone = var.az[count.index]

  tags = {
    Name = "${var.prefix}-${var.subnets_public[count.index].name}"
  }
}

# create private subnets 
resource "aws_subnet" "private" {
  count = length(var.az)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets_private[count.index].cidr
  availability_zone = var.az[count.index]

  tags = {
    Name = "${var.prefix}-${var.subnets_private[count.index].name}"
  }
}

# create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.prefix}_igw"
  }
}

# create elastic IP addresses for NGW
resource "aws_eip" "ngw" {
  count = length(var.az)
  vpc      = true
  tags = {
    Name = "${var.prefix}_eip"
  }
}

# create NAT gateways
# resource "aws_nat_gateway" "ngw" {
#   for_each = aws_subnet.public
#   allocation_id = aws_eip.ngw[count.index]
#   subnet_id = aws_subnet.public[count.index]
#   tags = {
#     Name = "${var.prefix}_eip"
#   } 
#   depends_on = [aws_internet_gateway.igw, aws_eip.ngw]
# }


