locals {
  bucket = "myappbucketph"
  bucketname = "MyApp S3 Bucket"
  iam_policy_name = "lambda-iam-policy"
  iam_policy_description = "For deployment of Lambda SAM"
  iam_assume_role_name = "github-lambda-assume-role"
  repo = "peter-heywood/lambda-api-endpoint"
}
