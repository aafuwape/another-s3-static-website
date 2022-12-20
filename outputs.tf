output "anthony_website_link" {
    description = "Link to the website"
    value = aws_s3_bucket.bucket1.website_endpoint
}
