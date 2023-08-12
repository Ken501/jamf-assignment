locals {
  kmadmin_public_ips  = ["173.168.83.231/32"] # Allows allocation of multiple public IPs. 

  route53_zone_map = {
    "test" = "kmartinez.net" # Allows allocation of multiple domains. i.e test-kmartinez.net, dev-kmartinez.net
    "dev"  = "kmartinez.net"
  }

  vpc_id_map = {
    us-east-1 = {
      "test" = "vpc-05fce31a38b22925f" # Allows allocation of multiple VPC IDs for multiple environments
      "dev"  = "vpc-05fce31a38b22925f"
    }
  }
  vpc_id = "${local.vpc_id_map[var.AWS_REGION]}"

  location_map = {
    us-east-1 = "use1" # Allows allocation of multiple regions
    us-east-2 = "use2"
  }

  subnet_id_map = {
    "public1"  = "${data.aws_subnet.public0.id}"
    "public2"  = "${data.aws_subnet.public1.id}"
    "private1" = "${data.aws_subnet.private0.id}"
    "private2" = "${data.aws_subnet.private1.id}"
  }

  subnet_cidr_map = {
    "public1"  = "${data.aws_subnet.public0.cidr_block}"
    "public2"  = "${data.aws_subnet.public1.cidr_block}"
    "private1" = "${data.aws_subnet.private0.cidr_block}"
    "private2" = "${data.aws_subnet.private1.cidr_block}"
  }

}

data "aws_subnet" "public0" {
  vpc_id = "${local.vpc_id[var.environment]}"

  filter {
    name   = "tag:Name"
    values = ["public0-subnet-${local.location_map[var.AWS_REGION]}"]
  }
}

data "aws_subnet" "public1" {
  vpc_id = "${local.vpc_id[var.environment]}"

  filter {
    name   = "tag:Name"
    values = ["public1-subnet-${local.location_map[var.AWS_REGION]}"]
  }
}

data "aws_subnet" "private0" {
  vpc_id = "${local.vpc_id[var.environment]}"

  filter {
    name   = "tag:Name"
    values = ["private0-subnet-${local.location_map[var.AWS_REGION]}"]
  }
}

data "aws_subnet" "private1" {
  vpc_id = "${local.vpc_id[var.environment]}"

  filter {
    name   = "tag:Name"
    values = ["private1-subnet-${local.location_map[var.AWS_REGION]}"]
  }
}

data "aws_route53_zone" "zone" {
  name = "${local.route53_zone_map[var.environment]}"
}

data "aws_acm_certificate" "wildcard_certificate" {
  domain      = "*.${local.route53_zone_map[var.environment]}"
  statuses    = ["ISSUED"]
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "aws_caller_identity" "current" {}
