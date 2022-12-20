# Add provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# add bucket
resource "aws_s3_bucket" "bucket1" {
  bucket = var.bucketname
  #acl    = "public-read"
  #policy = file("policy.json")
}

resource "aws_s3_bucket_website_configuration" "bucketwebsite" {
  bucket = aws_s3_bucket.bucket1.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

#bucket acl
resource "aws_s3_bucket_acl" "website_bucket_acl" {
  bucket = aws_s3_bucket.bucket1.id
  acl    = "public-read"
}

# bucket policy
resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.bucket1.id
  #policy = file("policy.json")
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "${aws_s3_bucket.bucket1.arn}/*"
            ]
        }
    ]
}
POLICY
}

# upload objects
resource "aws_s3_object" "index_file" {
  bucket = aws_s3_bucket.bucket1.id
  key    = "index.html"
  source = "./website/index.html"
  content_type = "text/html"
  etag = filemd5("./website/index.html")
}
resource "aws_s3_object" "error_file" {
  bucket = aws_s3_bucket.bucket1.id
  key    = "error.html"
  source = "./website/error.html"
  content_type = "text/html"
  etag = filemd5("./website/error.html")
}