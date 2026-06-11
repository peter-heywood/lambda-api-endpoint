# Permissions for lambda SAM
data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = [
				"cloudformation:*",
				"s3:GetObject",
				"s3:PutObject",
				"s3:GetBucketLocation",
				"lambda:*",
				"apigateway:*",
				"dynamodb:*",
				"iam:*"
			]
    resources = ["*"]
  }
}

# Permissions for assume role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = ["sts.amazonaws.com"]
    }
    condition {
      test = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = ["repo:${local.repo}*"]
    }
  }
}

# Our assume IAM role for GitHub actions
resource "aws_iam_role" "role" {
  name               = local.iam_assume_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# IAM Permissions policy for Lambda SAM deployment
resource "aws_iam_policy" "policy" {
  name        = local.iam_policy_name
  description = local.iam_policy_description
  policy      = data.aws_iam_policy_document.policy.json
}

# Attach permissions policy to our IAM assume role
resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

# Output the arn of our IAM assume role to add to GitHub secrets
output "aws_iam_role_arn" {
  value = aws_iam_role.role.arn
}