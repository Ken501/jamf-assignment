locals {

// Region Map

  region_map = {
    us-east-1 = "use1", # Leaves room for growth and expand regions
    us-west-1 = "usw1"
  }
  region_short = local.region_map[var.AWS_REGION]

// Subnet locals

  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]
  az                 = ["us-east-1a", "us-east-1b"]

// VPC and Subnet tags

  common_tags = {
    region            = "${var.AWS_REGION}"
    deployment_method = "auto"
    owner             = "${var.owner}"
  }

  vpc_tags = {
    Name = "kmadmin-network"
  }

  public01_tags = {
    Name = "public0-subnet-${local.region_short}"
    Tier = "public"
    "kubernetes.io/role/elb" = "1"
  }

  public02_tags = {
    Name = "public1-subnet-${local.region_short}"
    Tier = "public"
    "kubernetes.io/role/elb" = "1"
  }

  private01_tags = {
    Name = "private0-subnet-${local.region_short}"
    Tier = "private"
  }

  private02_tags = {
    Name = "private1-subnet-${local.region_short}"
    Tier = "private"
  }

}