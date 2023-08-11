// Cluster Add-ons

// CoreDNS
resource "aws_eks_addon" "coredns_addon" {
  cluster_name      = aws_eks_cluster.eks_cluster.name
  addon_name        = "coredns"
}

// EBS CSI
resource "aws_eks_addon" "ebs_addon" {
  cluster_name             = aws_eks_cluster.eks_cluster.name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.aws_ebs_controller_role.arn
}

//VPC CNI
resource "aws_eks_addon" "vpc_cni_addon" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"
}
