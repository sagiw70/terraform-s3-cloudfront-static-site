output "bucket_name" {
  description = "Name of the S3 bucket hosting the static website"
  value       = aws_s3_bucket.site_bucket.bucket
}

output "website_endpoint" {
  description = "S3 static website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name (HTTPS entry point)"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "uploaded_object_url" {
  description = "Public URL of the uploaded object in S3"
  value       = "https://${aws_s3_bucket.site_bucket.bucket}.s3.amazonaws.com/${var.object_key}"
}
