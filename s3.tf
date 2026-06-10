resource "aws_s3_bucket" "myapp_bucket" {
    # Replace ph with your initials
    bucket = "myappbucketph"
    tags = {
        Name = "MyApp S3 Bucket"
    }
}

output "object_s3_uri" {
  value = aws_s3_bucket.myapp_bucket.id
}