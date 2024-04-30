resource "aws_s3_bucket" "state_bucket" {
  bucket = var.storage
}


resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
