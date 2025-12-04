variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "bucket_name" {
  type    = string
  default = "sagi-terraform-bucket"
}

variable "file_path" {
  type    = string
  default = "image.png"
}

variable "object_key" {
  type    = string
  default = "uploaded-image.png"
}
