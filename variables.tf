locals {
  bucket = "myappbucketph"
  bucketname = "MyApp S3 Bucket"
  iam_assume_name = "GitLabAssumeRole"
  iam_policy_name = "lambda-iam-policy"
  iam_policy_description = "For deployment of Lambda SAM"
}
