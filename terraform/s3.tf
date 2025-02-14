// Provides a S3 bucket resource
resource "aws_s3_bucket" "terraform_state" {
    // Name of the bucket. If omitted, Terraform will assign a random, unique name.
    bucket = "monokai-s3-state-bucket"

    // Configuration of the S3 bucket versioning state
    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = false
    }

    tags = {
        Name = "Terraform State Bucket"
    }
}
