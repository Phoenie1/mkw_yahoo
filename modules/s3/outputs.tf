output "bucket_arn" {
  value = "${aws_s3_bucket.this.arn}"
}
output "kms_arn" {
  value = "${aws_kms_key.this.arn}"
}
output "bucket_endpoint" {
  value = "aws_s3_bucket_this.website_endpoint"
}
