locals {
  external_id = "edgescan-cloud-onboard-${random_id.external_id.hex}"
}

resource "aws_iam_role" "edgescan_integration" {
  name               = var.role
  assume_role_policy = data.aws_iam_policy_document.allow_edgescan_sts.json
}

// Enabling STS Trust Relationship
data "aws_iam_policy_document" "allow_edgescan_sts" {
  statement {
    sid = "EnableEdgescanSTS"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.edgescan_id}:root"]
    }

    actions = [
      "sts:AssumeRole"
    ]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [local.external_id]
    }
  }
}

// Policy attachments to AWS-managed policies
resource "aws_iam_role_policy_attachment" "ec2_read_only_access" {
  role       = aws_iam_role.edgescan_integration.name
  policy_arn = data.aws_iam_policy.ec2_read_only_access.arn
}

resource "aws_iam_role_policy_attachment" "route53_read_only_access" {
  role       = aws_iam_role.edgescan_integration.name
  policy_arn = data.aws_iam_policy.route53_read_only_access.arn
}

data "aws_iam_policy" "ec2_read_only_access" {
  name = "AmazonEC2ReadOnlyAccess"
}

data "aws_iam_policy" "route53_read_only_access" {
  name = "AmazonRoute53ReadOnlyAccess"
}

// In-line policy for account alias access
resource "aws_iam_role_policy" "read_only_account_alias" {
  role   = aws_iam_role.edgescan_integration.name
  name   = "ReadOnlyAWSAccountAlias"
  policy = data.aws_iam_policy_document.read_only_account_alias.json
}

data "aws_iam_policy_document" "read_only_account_alias" {
  statement {
    sid = "ReadOnlyAWSAccountAlias"

    effect = "Allow"

    actions = [
      "iam:ListAccountAliases"
    ]

    resources = ["*"]
  }
}

resource "random_id" "external_id" {
  byte_length = 8
}