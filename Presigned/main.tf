variable "aws_region" {
  default = "us-west-2"
}
provider "aws" {
  region = var.aws_region
}

resource "random_string" "random_name" {
  length  = 10
  special = false
  upper   = false
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "presigned-${random_string.random_name.result}"
}

resource "aws_s3_bucket_object" "example_object" {
  bucket = aws_s3_bucket.example_bucket.bucket
  key    = "seasides.jpeg"
  acl    = "private"
  source = "seasides.jpeg"
}

output "s3bucketname" {
  value = {
    BucketName = aws_s3_bucket.example_bucket.bucket
    URL = format("https://s3.console.aws.amazon.com/s3/buckets/%s/?region=%s",aws_s3_bucket.example_bucket.bucket,var.aws_region)
    arn        = aws_s3_bucket.example_bucket.arn
  }
}
