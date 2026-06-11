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

resource "aws_iam_policy" "policy" {
  name        = "lambda-iam-policy"
  description = "For deployment of Lambda SAM"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = local.iam_assume_name
  policy_arn = aws_iam_policy.policy.arn
}