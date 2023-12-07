#s3 bucket for backend
resource "aws_s3_bucket" "backend" {
  bucket = lower("New-${var.env}-${random_integer.backend.result}")

  tags = {
    Name        = "backend"
    Environment = "dev"
  }
}

#kms key for backend
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

# Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# random Integer for S3 Bucket
resource "random_integer" "backend" {
  min = 1
  max = 500
  keepers = {
    # Generate a new integer each time we switch to a new listener ARN
    Environment = var.env
  }
}

# Enabling Versioning
resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = var.ver
  }
}