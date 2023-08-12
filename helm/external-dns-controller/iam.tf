// External DNS Services Policy and Role

data "aws_iam_policy_document" "external_dns_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:external-dns-sa"]
    }

    principals {
      identifiers = [data.aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "external_dns_role" {
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role_policy.json
  name               = "${var.environment}-${var.app_name}-external-dns-${module.Global-Vars.location}"
}

resource "aws_iam_role_policy" "external_dns_role_policy" {
  name = "${var.environment}-${var.app_name}-external-dns-policy-${module.Global-Vars.location}"
  role = aws_iam_role.external_dns_role.id

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
})
}
