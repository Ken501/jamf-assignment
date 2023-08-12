// OpenID Provider

data "tls_certificate" "eks" {
    url = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
