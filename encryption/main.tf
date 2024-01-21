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
  bucket = "encrypted-bucket-${random_string.random_name.result}"
  force_destroy = true
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
    arn        = aws_s3_bucket.example_bucket.arn
  }
}
