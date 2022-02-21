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

variable "vpc_cidr" {
  description = "String representing the CIDR of the VPC CIDR block"
  type        = string
}

variable "region" {
  description = "String representing the region the solution is deployed to"
  type        = string
}

### Create resources

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    "Name" = "${var.prefix}-vpc"
  }
}

# For each type of subnet, create the same number of subnets as we have defined AZs
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
    Name = "${var.prefix}-igw"
  }
}

# create elastic IP addresses for NGW (one per private subnet)
resource "aws_eip" "ngw" {
  count = length(var.subnets_private)
  vpc      = true
  tags = {
    Name = "${var.prefix}-eip-${count.index}"
}
}

# create NAT gateways (one per private subnet)
resource "aws_nat_gateway" "ngw" {
  count = length(aws_subnet.public)
  allocation_id = aws_eip.ngw[count.index].id
  subnet_id = aws_subnet.public[count.index].id
  tags = {
    Name = "${var.prefix}-ngw-${count.index}"
  } 
  depends_on = [aws_internet_gateway.igw, aws_eip.ngw]
}

# create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}-public-rtb"
  }
  depends_on = [aws_internet_gateway.igw]
}

# create private route tables (one per private subnet)
resource "aws_route_table" "private" {
  count = length(aws_nat_gateway.ngw)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw[count.index].id
  }

  tags = {
    Name = "${var.prefix}-private-rtb-${count.index}"
  }
  depends_on = [aws_nat_gateway.ngw]
}

# assosciate public route table with public subnets
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# assosciate private route tables with private subnets
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# create s3 gateway endpoint
data "aws_route_tables" "rts" {
  vpc_id = aws_vpc.main.id

  filter {
    name   = "tag:Project"
    values = ["Dojo Weather App"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = data.aws_route_tables.rts.*.id
  tags = {
    Name = "${var.prefix}-s3-endpoint"
  }
}