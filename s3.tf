resource "aws_s3_bucket" "myapp_bucket" {
    # Replace ph with your initials
    bucket = local.bucket
    tags = {
        Name = local.bucketname
    }
}

output "object_s3_uri" {
  value = aws_s3_bucket.myapp_bucket.id
}