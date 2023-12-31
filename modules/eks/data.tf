// Cluster Auth for kubernetes provider

data "aws_eks_cluster" "eks_cluster" {
  name = "${var.environment}-${var.app_name}-cluster-${local.region_short}"

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}
data "aws_eks_cluster_auth" "cluster_auth" {
  name = "${var.environment}-${var.app_name}-cluster-${local.region_short}"

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}
