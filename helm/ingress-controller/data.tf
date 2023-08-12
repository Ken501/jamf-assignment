// EKS Cluster Data Resources

data "aws_eks_cluster" "eks_cluster" {
  name = "${var.environment}-${var.app_name}-cluster-${module.global-vars.location}"
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = "${var.environment}-${var.app_name}-cluster-${module.global-vars.location}"

}
