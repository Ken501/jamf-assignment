// Common Variables

variable "AWS_REGION" {
  description = "AWS preferred region"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Application lifecycle stage"
  type        = string
}

variable "key_name" {
  description = "EC2 Node Group ssh key"
  type        = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

// Cluster variables

variable "custom_cluster_name" {
  description = "Whether to enable custom name for EKS cluster resource"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "Custom name for EKS cluster"
  type        = string
  default     = ""
}

variable "custom_cluster_role" {
  description = "Whether to enable custom IAM role for EKS cluster resource"
  type        = bool
  default     = false
}

variable "cluster_role_name" {
  description = "Custom IAM Role name for EKS cluster"
  type        = string
  default     = ""
}

variable "custom_node_grp_name" {
  description = "Whether to enable custom name for Node Group"
  type        = bool
  default     = false
}

variable "node_grp_name" {
  description = "Custom name for Node Group"
  type        = string
  default     = ""
}

variable "custom_node_grp_role" {
  description = "Whether to enable custom name for Node Group IAM Role"
  type        = bool
  default     = false
}

variable "node_grp_role_name" {
  description = "Custom name for Node Group IAM Role"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of allowed IPs"
}

variable "subnets" {
  type        = list(string)
  description = "List of VPC Subnet IDs"
}

variable "endpoint_private_access" {
  description = "Whether to enable EKS Cluster API Private Access"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Whether to enable EKS Cluster API Public Access"
  type        = bool
  default     = true
}

variable "resource_tags" {
  description = "List of additional tags"
  type        = map(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

// Addon Variables

variable "coredns_addon_version" {
  description = "CoreDNS Cluster CNI addon version"
  type        = string
  default     = "v1.8.7-eksbuild.3"
}

// Controller Variables

variable "ebs_controller_version" {
  description = "EBS CSI controller version"
  type        = string
  default      = "v1.16.0"
}
