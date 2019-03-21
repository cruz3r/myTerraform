output "storage_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}

output "storage_name" {
  value = "${aws_s3_bucket.terraform_state.id}"
}

output "storage_domain_name" {
  value = "${aws_s3_bucket.terraform_state.bucket_domain_name}"
}