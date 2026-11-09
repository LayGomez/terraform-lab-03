output "bucket_name" {
  value = aws_s3_bucket.app.id
}

output "bucket_arn" {
  value = aws_s3_bucket.app.arn
}

output "aws_iam_user" {
  value = aws_iam_user.app.name
}