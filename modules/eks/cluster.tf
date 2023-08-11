// EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.custom_cluster_name ? var.cluster_name : local.default_cluster_name
  role_arn                  = var.custom_cluster_role ? var.cluster_role_name : local.default_cluster_role_name
  version                   = var.kubernetes_version
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids              = var.subnets
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids      = [aws_security_group.eks_sg.id]
    
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]

  tags = (merge(
    local.common_tags,
    var.resource_tags
  ))

}

// Nodes

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.custom_node_grp_name ? var.node_grp_name : local.default_node_grp_name
  node_role_arn   = var.custom_node_grp_role ? var.node_grp_role_name : local.default_node_grp_role_name
  subnet_ids      = var.subnets

  remote_access {
    ec2_ssh_key = var.key_name
  }

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = (merge(
    local.common_tags,
    var.resource_tags
  ))

}
