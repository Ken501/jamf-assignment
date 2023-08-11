// NameSpaces

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "${var.environment}-${var.app_name}-ns-${module.global-vars.location}"
  }
}

resource "kubernetes_namespace" "monitoring_namespace" {
  metadata {
    name = "monitoring"
  }
}