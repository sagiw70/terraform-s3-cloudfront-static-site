terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

########################################
# S3 bucket for hosting static website
########################################

resource "aws_s3_bucket" "site_bucket" {
  bucket = var.bucket_name
}

# Enable ownership controls to allow ACL usage
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.site_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Allow public access (required for S3 website hosting)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.site_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Set ACL to public-read
resource "aws_s3_bucket_acl" "public_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.public_access
  ]

  bucket = aws_s3_bucket.site_bucket.id
  acl    = "public-read"
}

# Configure static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.site_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Enable versioning for object history
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.site_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption (SSE-S3, AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.site_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Public read policy for website content
data "aws_iam_policy_document" "public_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id
  policy = data.aws_iam_policy_document.public_policy.json
}

########################################
# Upload website assets to S3
########################################

# Upload user-defined file
resource "aws_s3_object" "uploaded_file" {
  bucket = aws_s3_bucket.site_bucket.id
  key    = var.object_key
  source = var.file_path

  # Ensure the browser displays the image instead of downloading it
  content_type = "image/png"

  etag = filemd5(var.file_path)
}


# Upload index.html file
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.site_bucket.id
  key    = "index.html"
  source = "index.html"

  content_type = "text/html"
}

########################################
# CloudFront distribution (CDN + HTTPS)
########################################

resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  comment             = "Static website hosted on S3"
  default_root_object = "index.html"

  # S3 website endpoint as origin
  origin {
    domain_name = aws_s3_bucket_website_configuration.website.website_endpoint
    origin_id   = "s3-website-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  # Default behavior for content delivery
  default_cache_behavior {
    target_origin_id       = "s3-website-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  # Lower cost distribution class
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Use default CloudFront-managed certificate (HTTPS)
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
