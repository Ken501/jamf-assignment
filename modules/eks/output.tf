// Cluster Outputs

output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "oidc_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "host" {
  value = data.aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_ca_certificate" {
  value = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
}

output "token" {
  value = data.aws_eks_cluster_auth.cluster_auth.token
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}