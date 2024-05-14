resource "aws_s3_bucket" "bucket_test" {
  bucket = "rodrothbarthlifecycle1"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
    tags
    ]
  }

  tags = {
    test = "webstorm"
  }
}
