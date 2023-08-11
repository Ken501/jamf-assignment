// Local Variables

locals {

// Region Map

  region_map = {
    us-east-1 = "use1",
    us-west-1 = "usw1"
  }
  region_short = local.region_map[var.AWS_REGION]

  common_tags = {
    application       = "${var.app_name}"
    environment       = "${var.environment}"
    region            = "${var.AWS_REGION}"
    deployment_method = "auto"
    owner             = "${var.owner}"
  }

  // Local Cluster variables

  default_cluster_name = "${var.environment}-${var.app_name}-cluster-${local.region_short}"

  default_cluster_role_name = aws_iam_role.cluster_role.arn

  default_node_grp_name = "${var.environment}-${var.app_name}-node-grp-${local.region_short}"

  default_node_grp_role_name = aws_iam_role.node_role.arn

}
