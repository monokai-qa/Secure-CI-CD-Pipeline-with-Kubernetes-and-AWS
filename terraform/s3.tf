# Enable versioning using the new aws_s3_bucket_versioning resource
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = "monokai-s3-state-bucket"
  versioning_configuration {
    status = "Enabled"
  }
}

# Use the new aws_s3_bucket_lifecycle_configuration for lifecycle rules
resource "aws_s3_bucket_lifecycle_configuration" "terraform_state_lifecycle" {
  bucket = "monokai-s3-state-bucket"

  rule {
    id     = "prevent_destroy"
    status = "Enabled"

    expiration {
      days = 365
    }
  }
}
