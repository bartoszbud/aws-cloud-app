resource "aws_s3_bucket" "clapp-tf-state" {
  bucket_prefix = "clapp-tf-state-${var.environment}"
  force_destroy = var.force_destroy

  tags = {
    environment = var.environment
    purpose     = "tf-state"
  }
}

resource "aws_s3_bucket_public_access_block" "clapp-tf-state-public-access" {
  bucket = aws_s3_bucket.clapp-tf-state.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "clapp-tf-state-versioning" {
  bucket = aws_s3_bucket.clapp-tf-state.id

  versioning_configuration {
    status = "Enabled"
  }  
}

resource "aws_s3_bucket_lifecycle_configuration" "clapp-tf-state-lifecycle" {
  bucket = aws_s3_bucket.clapp-tf-state.id

  rule {
    id     = "expire-old-version"
    status = "Enabled"

    expiration {
      days = 90
    }
  }  
}

resource "aws_s3_bucket" "clapp-tf-state-log" {
  bucket_prefix = "clapp-tf-state-log-${var.environment}"

  tags = {
    environment = var.environment
    purpose     = "tf-state-log"
  }
}

resource "aws_s3_bucket_logging" "clapp-tf-state-bucket-logs" {
  bucket = aws_s3_bucket.clapp-tf-state-log.id

  target_bucket = aws_s3_bucket.clapp-tf-state-log.id
  target_prefix = "tf-state-logs-${var.environment}/"
}

resource "aws_dynamodb_table" "clapp-tf-state-lock" {
  name                        = "${var.table_name}-${var.environment}"
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "LockID"
  deletion_protection_enabled = false
  attribute {
    name = "LockID"
    type = "S"
  }
}