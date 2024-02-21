// Creates a simple VPC with public subnets and required routing
locals {
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = var.tags
}

resource "aws_subnet" "public" {
  count             = length(local.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  cidr_block        = element(local.public_subnet_cidrs, count.index)

  map_public_ip_on_launch = true
  
  tags = merge(
    var.tags,
    {
      "kubernetes.io/role/elb": "1",
      "kubernetes.io/cluster/${var.name_prefix}-cluster": "shared"
    }
  )
}

resource "aws_internet_gateway" "inet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_route" "inet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.inet_gateway.id
}

resource "aws_route_table_association" "public" {
  count          = length(local.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "default" {
  name        = "${var.name_prefix}-default-sg"
  description = "Default security group for VPC ${aws_vpc.vpc.id}"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  tags = var.tags
}
