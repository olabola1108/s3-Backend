output "s3-name" {
  value = aws_s3_bucket.backend.bucket
}

output "dynamo-table" {
  value = aws_dynamodb_table.dynamo-lock.id
}