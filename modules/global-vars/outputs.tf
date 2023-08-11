
output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "subnet_id_map" {
  value = "${local.subnet_id_map}"
}

output "subnet_cidr_map" {
  value = "${local.subnet_cidr_map}"
}

output "vpc_id" {
  value = "${local.vpc_id[var.environment]}"
}

output "kmadmin_public_ips" {
  value = "${local.kmadmin_public_ips}"
}

output "wildcard_certificate" {
  value = "${data.aws_acm_certificate.wildcard_certificate.arn}"
}

output "r53_zone_id" {
  value = "${data.aws_route53_zone.zone.zone_id}"
}

output "route53_zone" {
  value = "${local.route53_zone_map[var.environment]}"
}

output "location" {
  value = "${local.location_map[var.AWS_REGION]}"
}
