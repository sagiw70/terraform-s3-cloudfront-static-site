# Static Website Deployment with AWS S3 + CloudFront (Terraform IaC)

This project demonstrates how to deploy a static website on AWS using Terraform.  
It provisions an S3 bucket configured for static hosting, uploads the website files automatically, and distributes the content globally using CloudFront with HTTPS enabled.

---

## Project Overview

The application itself is intentionally simple (a static `index.html`), while the infrastructure represents real cloud deployment patterns:

- Automated provisioning with Terraform  
- S3 static website hosting  
- Public access management via IAM bucket policy  
- Encryption (AES-256), versioning, and ownership controls  
- File upload through Terraform  
- CloudFront CDN for HTTPS and global caching  

The focus is on IaC, AWS fundamentals, and secure, reproducible cloud architecture.

---

## Project Structure

main.tf — AWS infrastructure (S3, CloudFront, IAM)  
variables.tf — Input variables  
outputs.tf — Website and CDN URLs  
index.html — Static web page  
image.png — Uploaded demo file  

---

## Architecture Overview

CloudFront CDN (HTTPS, global caching)  
↓  
S3 Static Website (public read + website hosting enabled)  
↓  
S3 Bucket (versioning, encryption, IAM policy, uploaded objects)  

---

## Deployment Workflow

**Initialize Terraform**  
terraform init  

**Preview changes**  
terraform plan  

**Apply configuration**  
terraform apply  

Terraform provisions:

- S3 bucket  
- Static website configuration  
- AES-256 encryption  
- Bucket versioning  
- IAM public-read policy  
- Ownership controls  
- Uploads of index.html and image.png  
- CloudFront distribution  
- Output values with website and CDN URLs  

**Cleanup**  
terraform destroy

---

## Security Features

- Server-side encryption (AES-256)  
- Bucket versioning  
- IAM least-privilege policy for public access  
- Public Access Block configuration  
- Ownership controls  
- HTTPS enforced through CloudFront  

---

## Key Learnings

- Terraform workflow (state, variables, outputs, dependencies)  
- S3 website hosting mechanics  
- CloudFront origin behavior and propagation  
- IAM policy design and public access considerations  
- Troubleshooting: AccessDenied, ACL issues, missing index, content-type handling  
- Building secure and repeatable IaC deployments  

