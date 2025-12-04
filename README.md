# Static Website Deployment with AWS S3 + CloudFront (Terraform IaC)

This project demonstrates how to deploy a fully functional static website on AWS using **Terraform** as the Infrastructure-as-Code tool.  
The goal of this project was to build cloud infrastructure from scratch, understand the relationships between AWS services, and gain hands-on practice with IaC, S3 website hosting, permissions, and CDN distribution via CloudFront.

---

## 📌 Project Overview

Although the application itself is intentionally simple (a static `index.html` page), the **infrastructure** powering it mirrors real-world deployments:

### ✔ Provisioning cloud resources automatically with Terraform  
### ✔ Hosting static content on AWS S3  
### ✔ Configuring bucket policies, ACLs, encryption, and versioning  
### ✔ Uploading website files through Terraform  
### ✔ Distributing content globally using CloudFront (with HTTPS)  
### ✔ Understanding security concepts: public access, IAM policies, ownership controls, and website hosting  

This project focuses on the **workflow and infrastructure**, not the frontend — exactly the kind of foundations expected from CloudOps / DevOps entry-level roles.

---

## 📂 Project Structure

.
├── main.tf # AWS infrastructure (S3, CloudFront, IAM)
├── variables.tf # Input variables
├── outputs.tf # Website + CDN outputs
├── index.html # Static web page
└── image.png # Demo uploaded file

## 🧱 Architecture Diagram

               +-------------------------+
               |     CloudFront CDN      |
               |   (HTTPS, Global Edge)  |
               +------------+------------+
                            |
                            v
            +-------------------------------------+
            |   S3 Static Website (index.html)    |
            | Public Read + Website Configuration |
            +-------------------------------------+
                            |
                            v
   +------------------------------------------------------+
   |   S3 Bucket (Versioning, Encryption, ACL, Policies)  |
   |   + Uploaded image/object via Terraform              |
   +------------------------------------------------------+

   
---

## Deployment Workflow

#Initialize Terraform
terraform init

#Preview changes
terraform plan

#Apply configuration
terraform apply

Terraform then creates:

### ✔ S3 bucket

### ✔ Website hosting configuration

### ✔ Public-read policy

### ✔ Versioning and AES-256 encryption

### ✔ File uploads (HTML + image)

### ✔ CloudFront distribution

### ✔ Outputs containing the website URLs

## Website Endpoints

S3 website endpoint (HTTP)

CloudFront endpoint (HTTPS)

## Security Features

Server-side encryption (AES-256)

Bucket versioning

Restricted public access except required objects

IAM bucket policy (least privilege)

Ownership controls

HTTPS access through CloudFront

## Key Learnings

### ✔Building cloud infrastructure using Terraform

### ✔Understanding S3 website hosting behavior

### ✔Managing IAM policies and public access

### ✔CloudFront configuration and propagation

### ✔Debugging common issues (AccessDenied, ACL, content-type)

### ✔Deploying reproducible and secure IaC environments

