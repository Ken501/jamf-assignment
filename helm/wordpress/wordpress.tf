// wordpress

resource "helm_release" "wordpress" {
  name = "external-dns"

  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "wordpress"
  namespace  = "${var.environment}-${var.app_name}-ns-${module.global-vars.location}"

  set {
    name  = "replicaCount"
    value = "2"
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name  = "ingress.ingressClassName"
    value = "alb"
  }

  set {
    name  = "ingress.hostname"
    value = "wordpress.kmartinez.net"
  }

  set {
    name  = "ingress.annotations\\.alb\\.ingress\\.kubernetes\\.io/certificate-arn"
    value = "${module.global-vars.wildcard_certificate}"
  }

  set {
    name  = "ingress.annotations\\.alb\\.ingress\\.kubernetes\\.io/load-balancer-name"
    value = "${var.environment}-${var.app_name}-external-alb-${module.global-vars.location}"
  }

  set {
    name  = "ingress.annotations\\.alb\\.ingress\\.kubernetes\\.io/load-balancer-attributes"
    value = "deletion_protection.enabled=false"
  }

  set {
    name  = "ingress.annotations\\.alb\\.ingress\\.kubernetes\\.io/ip-address-type"
    value = "ipv4"
  }

  set {
    name  = "ingress.annotations\\.alb\\.ingress\\.kubernetes\\.io/tags"
    value = "Environment=${var.environment},Owner=${var.owner},App=${var.app_name}"
  }

  set {
    name  = "ingress.annotations\\.alb\\.ingress\\.kubernetes\\.io/listen-ports"
    value = '[{"HTTPS": 443}]'
  }

  set_list {
    name  = "ingress.annotations\\.alb\\.ingress\\.kubernetes\\.io/subnets"
    value = ["${module.global-vars.subnet_id_map["public1"]}", "${module.global-vars.subnet_id_map["public2"]}"]
  }

}
