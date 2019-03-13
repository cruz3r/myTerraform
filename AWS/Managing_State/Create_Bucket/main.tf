
resource "aws_s3_bucket" "terraform_state" {
    bucket = "${var.bucket_name}-state"
    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }
}

